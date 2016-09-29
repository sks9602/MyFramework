/**
 * 공통 팝업 Window창 생성 컴포넌트
 * 
 * ex) 회원 찾기.
 */

Ext.define('Ext.window.ux.WindowPopupMember', {
    extend: 'Ext.window.Window',
    alias: 'widget.windowPopupMember',
    title: '회원찾기',
    height: 600,
    width: 700,
    layout: 'fit',
    closeAction: 'hide',
    modal: true,
    resizable : false,
    border : 0,
    fields : ['COMPANY_ID','AAA'],
    setRecord: function(record) {
        this.record = record;
    },
    getRecord: function() {
        return this.record;
    },
    items: [
        {
            xtype: 'panel',
            autoScroll: true,
            layout: 'border',
            split: true,
            formBind: true,
            autoHeight: true,
            region: 'center',
            border: 0,
            style: {
                color: '#FFFFFF',
                backgroundColor: '#000000'
            },
            items: [
                Ext.create('Ext.ux.FormPanel', {
                    autoScroll: true,
                    url: '/s',
                    style: 'border-bottom: 0; ',
                    defaults: {
                        autoScroll: false,
                        anchor: '100%',
                        labelWidth: 100,
                        layout: {
                            type: 'hbox',
                            defaultMargins: {
                                top: 0,right: 5,bottom: 0,left: 0
                            }
                        }
                    },
                    border: 1,
                    title: '검색조건',
                    split: true,
                    collapsible: true,
                    region: 'north',
                    iconCls: 'top-search-title-icon',
                    collapsedCls: 'top-search-title',
                    cls: 'top-search-title',
                    splitterResize: false,
                    items: [{
                        xtype: 'fieldcontainer',
                        layout: {
                            type: 'hbox',
                            defaultMargins: {
                                top: 1,right: 5,bottom: 0,left: 0
                            }
                        },
                        items: [
                            {
                                xtype: 'hidden',
                                width: 320,
                                name: 'p_action_flag',
                                value: 'r_auth_list',
                                qtip: ''
                            } ,
                            {
                                xtype: 'textfield_ux',
                                fieldLabel: '권한 구분',
                                name: 'AUTH_NM',
                                qtip: '권한 구분'
                            } ,
                            {
                				xtype         : 'combotipple_ux', 
                				id            : 'id_win_pop_member_search_PAGE_SIZE',
                				first         : '',
                		        fieldLabel    : '조회 수', allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required',
                		        name          : 'PAGE_SIZE',
                		        valueField : 'CD_NM',
                		        value         : '30', 
                		        code          : 'SYS000', 
                		        store         : Ext.create('Ext.data.Store', {
                		            fields    : ['VALUE','NAME','GROUP','COMPANY_ID','CD','CD_NM','P_CD','FREE_1','FREE_2','FREE_3','FREE_4','FREE_5','FREE_6','FREE_7','FREE_8','FREE_9','ICON_CLS','COMMENTS','COMMENTS_TITLE' ],
                		            data      : [ 
                		            	  {VALUE:"SYS000001",NAME:"30",GROUP:"SYS000",COMPANY_ID:"0000",CD:"SYS000001",CD_NM:"30",P_CD:"SYS000",FREE_1:"",FREE_2:"",FREE_3:"",FREE_4:"",FREE_5:"",FREE_6:"",FREE_7:"",FREE_8:"",FREE_9:"",ICON_CLS:"",COMMENTS:"",COMMENTS_TITLE:""}
                		            	, {VALUE:"SYS000002",NAME:"50",GROUP:"SYS000",COMPANY_ID:"0000",CD:"SYS000002",CD_NM:"50",P_CD:"SYS000",FREE_1:"",FREE_2:"",FREE_3:"",FREE_4:"",FREE_5:"",FREE_6:"",FREE_7:"",FREE_8:"",FREE_9:"",ICON_CLS:"",COMMENTS:"",COMMENTS_TITLE:""}
                		            	, {VALUE:"SYS000003",NAME:"100",GROUP:"SYS000",COMPANY_ID:"0000",CD:"SYS000003",CD_NM:"100",P_CD:"SYS000",FREE_1:"",FREE_2:"",FREE_3:"",FREE_4:"",FREE_5:"",FREE_6:"",FREE_7:"",FREE_8:"",FREE_9:"",ICON_CLS:"",COMMENTS:"",COMMENTS_TITLE:""}
                		            ]
                		        })
                		     }
                        ]
                    }],
                    dockedItems: [{
                        xtype: 'toolbar',
                        dock: 'bottom',
                        flex: 1,
                        border: true,
                        items: [
                            '->', {
                                xtype: 'button',
                                border: 1,
                                iconCls: 'btn-icon-find',
                                style: {
                                    borderColor: '#99bce8',
                                    borderStyle: 'solid'
                                },
                                text: '조회',
                                handler: function() {
                                    if (this.up('form').getForm().isValid()) {
                                    	
                                        try {
                                            var store = this.up('window').down('grid').getStore();
                                            if( this.up('form').query('[id*=PAGE_SIZE]') ) { 
                                            	store.setPageSize( this.up('form').query('[id*=PAGE_SIZE]')[0].getValue()); 
                                            }
                                            
                                            store.load({
                                                    page: 1,
                                                    limit : (this.up('form').query('[id*=PAGE_SIZE]') ? this.up('form').query('[id*=PAGE_SIZE]')[0].getValue() : 30 ) ,
                                                    params: this.up('form').getForm().getFieldValues(false)
                                                });
                                            store.currentPage = 1;
                                            store.params = this.up('form').getForm().getFieldValues(false);
                                            
                                        	store.on('load',
                                                function(_this) {
                                                    if ((_this.getTotalCount && _this.getTotalCount() < 0)) {
                                                        hoAlert('연결이 종료 되었습니다.',fs_goLoginPage);
                                                    } else if (!_this.getTotalCount) {
                                                        var records = arguments[2];
                                                        if (records[0].get('id') < 0) {
                                                            hoAlert('연결이 종료 되었습니다.',fs_goLoginPage);
                                                        }
                                                    }
                                                });
                                        } catch (e) {
                                            alert(e);
                                        }
                                    } else {
                                        this.up('form').getForm().findInvalid();
                                    }
                                }
                            }
                        ]
                    }]
                }),
                Ext.create(
                    'Ext.grid.Panel', {

                        width: 500,
                        minWidth: 500,

                        viewConfig: {
                            forceFit: true,
                            copy: true
                        },
                        submitModified: false,

                        region: 'center',

                        columnLines: true,

                        tools: [{
                            type: 'close',
                            tooltip: 'Delete fields Sql-ID',
                            handler: function( event,toolEl,panelHeader) {
                                Ext.Ajax.request({
                                        url: '/s/system/page.do',
                                        params: {
                                            p_action_flag: 'b_delete_grid_sqlId',
                                            sql_id: 'Auth.selectAuthList'
                                        },
                                        success: function(response) {
                                            var res = Ext.JSON.decode(response.responseText);

                                            Ext.create('widget.uxNotification', {
                                                        title: '삭제결과',
                                                        position: 'br',
                                                        manager: 'demo1',
                                                        iconCls: 'ux-notification-icon-information',
                                                        autoCloseDelay: 3000,
                                                        spacing: 50,
                                                        html: res.message
                                            }).show();
                                        }
                                    });
                            }
                        }],

                        store: Ext.create('Ext.data.JsonStore', {
                            storeId: 'id_win_pop_member_store_grid_id_member',
                            autoDestroy: true,
                            remoteSort: true,
                            pageSize: 30,

                            fields: [
                                'AUTH_DESC',
                                'AUTH_ID',
                                'AUTH_NM',
                                'ID',
                                'TEXT'
                            ],
                            proxy: Ext.create('Ext.data.HttpProxy', {
                                type: 'ajax', // 'memory',
                                url: '/s/system/auth.do',
                                reader: {
                                    type: 'json',
                                    totalProperty: 'totalCount',
                                    root: 'datas'
                                },
                                writer: {
                                    type: 'singlepost', // 'json',
                                    writeAllFields: true,
                                    encode: true,
                                    root: 'datas',
                                    params: {}, // @TODO
                                    allowSingle: false
                                },
                                api: {
                                    create: '/s/system/auth.do',
                                    update: '/s/system/auth.do'
                                }
                            }),
                            listeners: {
                                beforeload: function(store,operation, eOpts) {
                                    if (store.sorters && store.sorters.getCount()) {
                                        var sorter = store.sorters.getAt(0);

                                        var sortProp = sorter.property;

                                        Ext.apply(tore.getProxy().extraParams,store.params);
                                        Ext.apply(store.getProxy().extraParams, {
                                                'sort': sortProp,
                                                'dir': sorter.direction
                                        });
                                    }
                                }
                            }
                        }),

                        border: 1,

                        selType: 'cellmodel',

                        margin: '0 0 0 0',

                        columns: {
                            items: [
                                {
                                    xtype: 'rownumberer',
                                    text: 'No',
                                    width: 40,
                                    style: 'text-align:center'
                                },
                                {
                                    dataIndex: 'AUTH_ID',
                                    header: '성명',
                                    sortable: true,
                                    style: 'text-align:center',
                                    align: 'center',
                                    width: 120,
                                    isLoad: true
                                },
                                {
                                    dataIndex: 'AUTH_NM',
                                    header: '사번',
                                    sortable: true,
                                    style: 'text-align:center',
                                    align: 'center',
                                    flex: 1,
                                    width: 100,
                                    renderer: function(value, metaData,record) {
                                        return Ext.String.format("<span class=\"in_grid_url_link\">{0}</span>",
                                                value,
                                                record.data.AUTH_ID,
                                                metaData);
                                    },
                                    isLoad: true
                                }
                            ]
                        },

                        listeners: {

                            cellclick: function( table, td, cellIndex, record, tr, rowIndex, e, eOpts) {
                                var popMemberWin = this.up('window');

                                var openerRecord = popMemberWin.getRecord();
                                openerRecord.set( 'MEMBER_ID',  record.get('AUTH_ID'));
                                openerRecord.set( 'MEMBER_NM',  record.get('AUTH_NM'));
                                
                                if( popMemberWin.fields) {
                                	for( var i in popMemberWin.fields ) {
                                		var field = popMemberWin.fields[i];
                                		openerRecord.set( field,  record.get(field));
                                	}
                                }
                                
                                popMemberWin.hide(td);
                            }
                        },

                        dockedItems: [
                            Ext.create('Ext.ux.PagingToolbar', {
                                displayInfo: true,
                                dock: 'bottom',
                                border: 1,
                                pageCnt: 3,
                                store: Ext.getStore('id_win_pop_member_store_grid_id_member'),
                                emptyMsg: "No topics to display"
                                
                            })
                        ] // end of dockedItems
                    }) // Ext.create
                // 'Ext.grid.Panel'

            ]
        }

    ]
})