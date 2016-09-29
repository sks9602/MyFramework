//  http://jsfiddle.net/timvasil/2gVUh/1/ 참조..
// <script type='text/javascript' src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
// <script type='text/javascript' src="http://omnipotent.net/jquery.sparkline/2.1.1/jquery.sparkline.min.js"></script>
/**
 * @class Ext.ux.column.Sparkline
 * @author Tim Vasil <tim@timvasil.com>
 * 
 * Column to render sparklines via jQuery's Sparkline library (http://omnipotent.net/jquery.sparkline).
 *
 * For the best experience with this extension:
 * 
 * 1) See the "manualUpdate" property for information on preventing flicker during dynamic updates.
 * 2) Add a CSS style to ensure the tooltip is sized correctly by overriding incompatible Ext JS sizing:
 *    <pre>
 *    .jqstooltip {
 *       box-sizing: content-box;
 *       height: auto !important;
 *       width: auto !important;
 *    }
 *    </pre> 
 * 
 * MIT open source license
 */
Ext.define('Ext.ux.column.Sparkline', {
    extend: 'Ext.grid.column.Column',
    alias: ['widget.sparklinecolumn'],

    /**
     * {@cfg} {Object/Object[]} sparklineConfig 
     * 
     * Sparkline configuration object, as defined by the jQuery Sparkline API to be used across
     * all rows in this column.  This property is optional.
     * 
     * The config object is passed into the $.sparkline method to draw the sparkline.  If you specify an array of objects,
     * they're treated as composite configs and the charts are laid out on top of each other; you
     * can use this to create a multi-series sparkline.  As noted in the Sparkline documentation,
     * you may wish to set common min/max values across charts.  As a convenience, this implementation 
     * will automatically set the "composite" property to true for you on the subsequent configs in the array.
     * 
     * The special "dataIndex" property of the sparklineConfig object indicates the property
     * of the record to obtain the array of values for the chart.  If not specified, the dataIndex property
     * of the column is sued.
     * 
     * If you'd prefer to configure each cell's sparkline differently, leave sparklineConfig
     * undefined and set dataIndex to the property name in your model with values in this format:
     * <pre>
     * {
     *     config: { sparklineConfig },
     *     value: [ array of values for the chart ]
     * }
     * </pre> 
     */

    /**
     * {@cfg} {Boolean} minDataIndex
     * 
     * Optional data index to fetch the min value to be used across all charts (the chartRangeMin property).
     * 
     * Indicates whether the "min" should be set identically across all charts in the column.  When true, the min is 
     * determined dynamically by the smallest value of this property in the store.
     */
    
    /**
     * {@cfg} {Boolean} maxDataIndex
     * 
     * Optional data index to fetch the max value to be used across all charts (the chartRangeMax property).
     * 
     * Indicates whether the "max" should be set identically across all charts in the column.  When true, the max is 
     * determined dynamically by the largest value of this property in the store.
     */
    
    /**
     * Set to true to prevent flicker when Ext JS clears out cell contents during rendering updates.
     * This leaves the old sparkline in place until the async rendering of this class has a chance to overwrite it.
     * 
     * For this setting to work, you must apply a patch to Ext JS as follows:
     * <pre>
     *     Ext.override(Ext.grid.View, {
     *         shouldUpdateCell: function(column, changedFieldNames) {
     *             if (column.manualUpdate) {
     *                 return false;
     *             }
     *             return this.callParent(arguments);
     *         }
     *     });
     * </pre>
     * 
     * As an alternative, you can set "dataIndex" to a property that doesn't change across updates.
     * The drawback to this approach is you can no longer rely on native grid sorting.
     */
    manualUpdate: true,
    
    /**
     * Specifies the number of cells to render before relinquishing control back to the browser to process
     * user activity and other events.  Note that this setting applies to cells, not individual sparklines,
     * so if you have 5 composite sparklines in a cell that counts as just 1 rendering in the limit
     * specified here. 
     */
    asyncRenderMaxCells: 10,
    
    /** @Override */
    initComponent: function() {
        var me = this;

        if (me.sparklineConfig && !Ext.isArray(me.sparklineConfig)) {
            me.sparklineConfig = [me.sparklineConfig];
        }

        // IDs of cells whose charts need rendering
        me.syncQueue = [];

        // Map of IDs to sparkline values (for charts that need rendering)
        me.syncQueueData = {};

        me.callParent(arguments);
    },

    /** @Override */
    onAdded: function(container) {
        var me = this;

        // Hook column resize events so we can redraw sparklines whose widths are a percentage of the column width
        container.on('columnresize', function() {
            if (me.sparklineConfig && !/.*%$/.test(me.sparklineConfig.width)) {
                // Sparkline width is not a percentage -- no redraw needed
                return;
            }

            var grid = me.up('grid');
            var view = grid.getView();
            var store = grid.getStore();
            store.each(function(record) {
                // Redraw chart in this cell
                view.onUpdate(store, record, null, [me.dataIndex]);
            });
        });

        me.callParent(arguments);
    },

    /** @Override */
    defaultRenderer: function(value, metaData, record, rowIdx, colIdx, store, view) {
        var me = this;
        var config = me.sparklineConfig;
        var data;

        if (me.sparklineConfig) {
            data = [];
            for ( var i = 0; i < config.length; i++) {
                data.push({
                    config: config[i],
                    value: (config[i].dataIndex) ? record.get(config[i].dataIndex) : value
                });
            }
        } else {
            data = value;
        }

        // The only rendering we do synchronously is attaching an ID to the cell (column ID + record ID)
        var id = me.getId() + '-' + record.getId();
        metaData.tdAttr = 'id="' + id + '"';

        if (data) {
            // Asynchronously draw the sparkline.  We can't do it synchronously because: 
            // 1) this render method's HTML is buffered, not appended to the DOM immediately, and 
            // 2) it's not performance for more than 10 rows (especially in IE)
            if (!me.syncQueueData[id]) {
                me.syncQueue.push(id);
            }
            me.syncQueueData[id] = data;
            me.setSyncTimer();
        }
        return '';
    },

    /** @Override */
    destroy: function() {
        clearTimeout(me.syncTimer);
        this.callParent(arguments);
    },

    /**
     * @private
     * 
     * Ensures a timer is set to render all pending sparklines as soon as this thread completes its work.
     */
    setSyncTimer: function() {
        var me = this;
        if (!me.syncTimer) {
            me.syncTimer = setTimeout(function() {
                me.renderFromQueue();
            }, 0);
        }
    },

    /**
     * @private
     * 
     * Renders sparklines that need to be (re)drawn based on what's in the queue. To avoid noticeable lag, only a subset of
     * the queued items (which are processed in FIFO order) may be processed. If not all items are rendered, setSyncTimer is
     * called to process the remaining items as soon as this thread completes its work. (This allows the browser to process
     * user-initiated UI events before we resume rendering sparklines.)
     */
    renderFromQueue: function() {
        var me = this;
        var i = 0;
        delete me.syncTimer;

        var min = (me.minDataIndex) ? me.up('grid').getStore().max(me.minDataIndex) : undefined;
        var max = (me.maxDataIndex) ? me.up('grid').getStore().max(me.maxDataIndex) : undefined;

        // Limit the amount of rendering at one time to ensure the browser (especially IE) remains responsive
        for (i = 0; i < me.asyncRenderMaxCells && i < me.syncQueue.length; i++) {
            var id = me.syncQueue[i];
            var data = me.syncQueueData[id];
            var el = $('#' + id);
            delete me.syncQueueData[id];

            if (!el[0]) {
                // DOM element no longer exists -- nothing to do
                return;
            }

            if (!Ext.isArray(data)) {
                data = [data];
            }

            for ( var j = 0; j < data.length; j++) {
                var config = data[j].config;
                var value = data[j].value;

                if (min !== undefined) {
                    config.chartRangeMin = min;
                }
                if (max !== undefined) {
                    config.chartRangeMax = max;
                }
                if (j > 0) {
                    config.composite = true;
                }
                el.sparkline(value, config);
            }
        }

        // Remove the work we've done from the queue 
        me.syncQueue.splice(0, i);
        
        // Set the timer again if there's more work left to do
        if (me.syncQueue.length > 0) {
            me.setSyncTimer();
        }
    }
});


function addDataSamples(store) {
    store.each(function (item) {
        var cpu = addDataSample(item.get('cpuHistory'), 0, 100, 20);
        addDataSample(item.get('cpuKernelHistory'), 0, cpu * 0.9, 20);
        var memory = addDataSample(item.get('memoryHistory'), 0, 1024 * 1024 * 1024 * 32, 1024 * 1024 * 32);

        item.set('cpu', cpu);
        item.set('memory', memory);
        item.set('lastUpdate', new Date());
    });
}

function addDataSample(history, min, max, maxInc) {
    var value = Math.min(max, Math.max(min, (history[history.length - 1] || 0) + Ext.Number.randomInt(-maxInc, maxInc)));
    while (history.length >= 10) {
        history.shift();
    }
    history.push(value);
    return value;
}

Ext.override(Ext.grid.View, {
    shouldUpdateCell: function (column, changedFieldNames) {
        if (column.manualUpdate) {
            return false;
        }
        return this.callParent(arguments);
    }
});

Ext.onReady(function () {

    var customData = [10, -2, 30, 10, 100, 40, 6, 78, 23];
    var customLines = [{
        config: {
            type: 'bar'
        },
        value: [10, -2, 30, 10, 100, 40, 6, 78, 23]
    }, {
        config: {
            type: 'bar'
        },
        value: ['0:2', '2:4', '4:2', '4:1']
    }, [{
        config: {
            type: 'bar'
        },
        value: [10, -2, 30, 10, 100, 40, 6, 78, 23]
    }, {
        config: {
            type: 'line'
        },
        value: [-2, 30, 10, 100, 40, 6, 78, 23, 4]
    }], {
        config: {
            type: 'line'
        },
        value: [10, -2, 30, 10, 100, 40, 6, 78, 23]
    }, {
        config: {
            type: 'box',
            maxSpotColor: 'red'
        },
        value: [10, -2, 30, 10, 100, 40, 6, 78, 23]
    }, {
        config: {
            type: 'tristate'
        },
        value: [10, -2, 30, 10, 100, 40, 6, 78, 23]
    }, {
        config: {
            type: 'discrete'
        },
        value: [10, -2, 30, 10, 100, 40, 6, 78, 23]
    }, {
        config: {
            type: 'pie'
        },
        value: [10, -2, 4]
    }, {
        config: {
            type: 'bullet'
        },
        value: [10, 12, 12, 9, 7]
    }];

    Ext.define('Host', {
        extend: 'Ext.data.Model',
        idProperty: 'id',
        fields: ['id', 'name', 'cpu', 'cpuHistory', 'cpuKernelHistory', 'memory', 'memoryHistory', 'custom', 'lastUpdate']
    });

    var store = Ext.create('Ext.data.Store', {
        model: 'Host'
    });

    for (var i = 1; i <= 10; i++) {
        store.add({
            id: i,
            name: 'Process ' + i,
            cpuHistory: [],
            cpuKernelHistory: [],
            memoryHistory: [],
            custom: customLines[i - 1]
        });
    }
    for (i = 0; i < 10; i++) {
        addDataSamples(store);
    }

    var grid = Ext.create('Ext.grid.Panel', {
        renderTo: 'autoUpdateGrid',
        width: 600,
        height: 250,
        store: store,

        viewConfig: {
            markDirty: false
        },

        columns: [{
            text: 'Name',
            dataIndex: 'name'
        }, {
            text: 'CPU',
            dataIndex: 'cpu',
            align: 'right',
            width: 50,
            renderer: function (value) {
                return Ext.util.Format.number(value, '0%');
            }
        }, {
            text: 'CPU history',
            xtype: 'sparklinecolumn',
            dataIndex: 'cpuHistory',
            width: 110,

            sparklineConfig: [{
                type: 'line',
                dataIndex: 'cpuHistory',
                height: '19',
                width: '100%',
                chartRangeMin: 0,
                chartRangeMax: 1,
                spotColor: '',
                maxSpotColor: '',
                minSpotColor: '',
                highlightLineColor: '#000',
                highlightSpotColor: '#000',
                lineColor: '#080',
                fillColor: '#cec',
                tooltipFormatter: function (sparkline, options, fields) {
                    return Ext.util.Format.number(fields.y, '0%') + ' total<br />';
                }
            }, {
                type: 'line',
                dataIndex: 'cpuKernelHistory',
                chartRangeMin: 0,
                chartRangeMax: 1,
                spotColor: '',
                maxSpotColor: '',
                minSpotColor: '',
                highlightLineColor: '#000',
                highlightSpotColor: '#000',
                lineColor: '#800',
                fillColor: '#ecc',
                tooltipFormatter: function (sparkline, options, fields) {
                    return Ext.util.Format.number(fields.y, '0%') + ' kernel';
                }
            }]
        }, {
            text: 'Memory',
            dataIndex: 'memory',
            align: 'right',
            width: 100,
            renderer: function (value) {
                return Ext.util.Format.fileSize(value);
            }
        }, {
            text: 'Memory history',
            xtype: 'sparklinecolumn',
            dataIndex: 'memory',
            width: 110,

            maxDataIndex: 'memory',

            sparklineConfig: {
                type: 'line',
                dataIndex: 'memoryHistory',
                height: '19',
                width: '100%',
                spotColor: '',
                maxSpotColor: '',
                minSpotColor: '',
                highlightLineColor: '#000',
                highlightSpotColor: '#000',
                lineColor: '#008',
                fillColor: '#cce',
                tooltipFormatter: function (sparkline, options, fields) {
                    return Ext.util.Format.fileSize(fields.y);
                }
            }
        }, {
            text: 'Custom',
            xtype: 'sparklinecolumn',
            dataIndex: 'custom',
            width: 100,
            tdCls: 'custom-col'
        }]
    });

    setInterval(function () {
        addDataSamples(store);
    }, 1000);
});