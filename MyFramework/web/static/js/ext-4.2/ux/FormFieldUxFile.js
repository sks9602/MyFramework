
/**
* @private
* @class Ext.ux.layout.component.field.UploadFileField
* @extends Ext.layout.component.field.Trigger
* @author Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* @docauthor Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* 
* Layout class for {@link Ext.ux.form.field.UploadFileField} fields. Handles sizing the image field upload.
*/
Ext.define('Ext.ux.layout.component.field.UploadFileField', {
    alias: ['layout.uploadfilefield'],
    extend: 'Ext.layout.component.field.Trigger',

    type: 'uploadfilefield',

    publishInnerWidth: function (ownerContext, width) {
        var me = this,
            owner = me.owner;
        
        owner.browseButtonWrap.setWidth(owner.button.getWidth() + owner.buttonMargin + owner.buttonDelete.getWidth() + owner.buttonDeleteMargin);
        owner.buttonDelete.setHeight(owner.button.getHeight());
    },
    
    sizeBodyContents: function(width, height) {
        var me = this,
            owner = me.owner;

        if (!owner.buttonOnly) {
            me.setElementSize(owner.inputEl, Ext.isNumber(width) ? width - owner.button.getWidth() - owner.buttonMargin - owner.buttonDelete.getWidth() - owner.buttonDeleteMargin : width);
        }
    }
});

/**
* @class Ext.ux.form.field.UploadFileField
* @extends Ext.form.field.File
* @author Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* @docauthor Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* @license [MIT][1]
* 
* @version 1.2
* 
* [1]: http://www.mzsolutions.eu/extjs/license.txt
* 
* 
* Provides a "delete" button to the file upload component. If the "delete" button is pressed the component behaves like a 
* textfield sending the value "delete" to the server. This is useful when you want to delete the uploaded file.
* The component works with Extjs > 4.0.7 and < 4.1.1.
* 
* ### Changelog:
* 
* #### 03.10.2012 - v1.2
* 
* - if the field is readOnly then disable "delete" and "browse" buttons
* - raise the "deletefile" event when the "delete" button is pressed
* 
* 
#Example usage:#
{@img Ext.ux.form.field.UploadFileField.png Ext.ux.form.field.UploadFileField component}
    var form = Ext.create('Ext.form.Panel', {
        title:          'File upload',
        bodyPadding:    10,
        width:          300,
        renderTo: Ext.getBody(),        
        items: [{
            xtype:      'uploadfilefield',
            name:       'name',
            anchor:     '100%',
            fieldLabel: 'File'
        }],
        
        buttons: [{
            text: 'Save'
        }]
    }); 
*/
Ext.define('Ext.ux.form.field.UploadFileField', {
    extend: 'Ext.form.field.File',
    alias: 'widget.uploadfilefield',
    alternateClassName: 'Ext.form.UploadFileField',

    componentLayout: 'uploadfilefield',
    labelSeparator : '', 
    vtype:'fileUpload',
    msgTarget  : 'side', 
    
    /**
    * @cfg {String} buttonDeleteText Set the delete button caption.
    */
    buttonDeleteText:  'Delete',
    /**
    * @cfg {String} buttonDeleteMargin Set the margin of the delete button.
    */
    buttonDeleteMargin: 3,
    readOnly: false,
    
    initComponent : function(){
        var me = this;
        me.readOnlyTemp = me.readOnly || false;
        
        me.readOnly = true; // temporarily make it readOnly so that the parent function work properly
        me.addEvents(
            /**
             * @event deletefile
             * Fires when the delete file button is pressed
             * @param {Ext.ux.form.field.UploadFileField} this
             * @param {boolean} pressed
             */
            'deletefile'
        );
        me.callParent(arguments);
    },

    onRender: function() {
        var me = this;

        me.callParent(arguments);
        me.createDeleteButton();
        me.onReadOnly(me.readOnlyTemp);
    },
    
    setReadOnly: function(readOnly){
        var me = this;
        
        me.onReadOnly(readOnly);
        me.readOnly = readOnly;
    },
    
    onReadOnly: function(readOnly){
        var me = this;

        if(me.button){
            me.button.setDisabled(readOnly);
        }
        if(me['buttonEl-btnEl']){
            me['buttonEl-btnEl'].dom.disabled = readOnly;
        }
        if(me.fileInputEl){
            me.fileInputEl.dom.disabled = readOnly;
        }
        if(me.buttonDelete){
            me.buttonDelete.setDisabled(readOnly);
        }
    },
    
    onDisable: function(){
        var me = this;
        
        me.callParent(arguments);
        if(me.buttonDelete){
            me.buttonDelete.setDisabled(true);
        }
    },
    
    onEnable: function(){
        var me = this;

        me.callParent(arguments);
        if(me.buttonDelete){
            me.buttonDelete.setDisabled(false);
        }
    },
    
    createDeleteButton: function(){
        var me = this;
        var parent = me.browseButtonWrap ? me.browseButtonWrap : me.bodyEl;
        me.buttonDelete = Ext.widget('button', Ext.apply({
            ui:             me.ui,
            renderTo:       parent,
            text:           me.buttonDeleteText,
            cls:            Ext.baseCSSPrefix + 'form-file-btn',
            preventDefault: true,
            pressed:        false,
            style:          'margin-left:' + (me.buttonDeleteMargin-1) + 'px',
            toggleHandler:  me.handleDelete,
            enableToggle:   true,
            scope:          me
        }, me.buttonDeleteConfig));

    },
    
    handleDelete: function(btn, pressed, e){
        var me = this;
        
        if(pressed){
            me.originalValue = me.getValue();
            me.setValue('');
            me.fireEvent('deletefile', me, true);
        }else{
            me.setValue(me.originalValue);
            me.fireEvent('deletefile', me, false);
        }
    },
    
    isFileUpload: function(){
        return this.getValue() != 'delete';
    },
    
    setValue: function(value){
        var me = this,
            buttonDelete = me.buttonDelete;

        if(buttonDelete && value != 'delete'){
            buttonDelete.toggle(false, true);
        }

        me.setRawValue(me.valueToRaw(value));
        return me.mixins.field.setValue.call(me, value);
    },
    
    onDestroy: function(){
        Ext.destroyMembers(this, 'buttonDelete');
        this.callParent();
    }
});

/**
* @private
* @class Ext.ux.layout.component.field.ImageFileField
* @extends Ext.layout.component.field.Field
* @author Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* @docauthor Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* 
* Layout class for {@link Ext.ux.form.field.ImageFileField} fields. Handles sizing the image field upload.
*/
Ext.define('Ext.ux.layout.component.field.ImageFileField', {
    alias: ['layout.imagefield'],
    extend: 'Ext.layout.component.field.Trigger',

    type: 'imagefield',

    publishInnerWidth: function (ownerContext, width) {
        var me = this,
            owner = me.owner;
        
        owner.browseButtonWrap.setWidth(owner.button.getWidth() + owner.buttonMargin + owner.buttonDelete.getWidth() + owner.buttonDeleteMargin + owner.buttonPreview.getWidth() + owner.buttonPreviewMargin);
        owner.buttonDelete.setHeight(owner.button.getHeight());
        owner.buttonPreview.setHeight(owner.button.getHeight());
    },
    
    sizeBodyContents: function(width, height) {
        var me = this,
            owner = me.owner;

        if (!owner.buttonOnly) {
            me.setElementSize(owner.inputEl, Ext.isNumber(width) ? width - owner.button.getWidth() - owner.buttonMargin - owner.buttonDelete.getWidth() - owner.buttonDeleteMargin - owner.buttonPreview.getWidth() - owner.buttonPreviewMargin : width);
        }
    }
    
});

/**
* @class Ext.ux.form.field.ImageFileField
* @extends Ext.ux.form.field.UploadFileField
* @author Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* @docauthor Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* @license [MIT][1]
* 
* @version 1.2
* 
* [1]: http://www.mzsolutions.eu/extjs/license.txt
* 
* 
* Provides an image upload field component for Sencha. The field allows you to preview the image that was previously uploaded.
* The component works with Extjs > 4.0.7 and < 4.1.1.
* 
* ### Changelog:
* 
* #### 03.10.2012 - v1.2
* 
* - if the delete button is pressed then disable preview
* - if the field is readOnly then disable "delete" and "browse" buttons
* 
* 
#Example usage:#
{@img Ext.ux.form.field.ImageFileField.png Ext.ux.form.field.ImageFileField component}
    var form = Ext.create('Ext.form.Panel', {
        title:          'Image upload',
        bodyPadding:    10,
        width:          300,
        renderTo: Ext.getBody(),        
        items: [{
            xtype:      'imagefield',
            name:       'name',
            anchor:     '100%',
            fieldLabel: 'Image'
        }],
        
        buttons: [{
            text: 'Save'
        }]
    }); 
*/
Ext.define('Ext.ux.form.field.ImageFileField', {
    extend: 'Ext.ux.form.field.UploadFileField',
    alias: ['widget.imagefilefield', 'widget.imagefield'],
    alternateClassName: 'Ext.form.ImageFileField',

    componentLayout: 'imagefield',
    /**
    * @cfg {String} buttonPreviewText Set the preview button caption.
    */
    buttonPreviewText:  'Preview',
    /**
    * @cfg {String} buttonPreviewMargin Set the margin of the preview button.
    */
    buttonPreviewMargin: 3,
    /**
    * @cfg {String} imageRootPath Set the root URL to the uploaded picture
    */
    imageRootPath:      '/',
    
    onRender: function() {
        var me = this;

        me.callParent(arguments);
        me.createPreviewButton();
        
        if(!Ext.isEmpty(me.getValue())){
            me.buttonPreview.enable();
        }
        me.on('deletefile', me.deletePressed, me);
    },
    
    onDisable: function(){
        var me = this;
        
        me.callParent(arguments);
        if(me.buttonPreview){
            me.buttonPreview.setDisabled(true);
        }
    },
    
    onEnable: function(){
        var me = this;

        me.callParent(arguments);
        if(me.buttonPreview){
            me.buttonPreview.setDisabled(!Ext.isEmpty(me.getValue()));
        }
    },
    
    deletePressed: function(field, pressed){
        var me = this;
        if(me.buttonPreview){
            me.buttonPreview.setDisabled(pressed);
        }  
        if( Ext.getCmp(me.getId()+"_preview") ) {
        	Ext.get(me.getId()+'_preview_text').setDisplayed(true);
        	
			var imgSrc = Ext.getCmp(me.getId()+"_preview");
			imgSrc.setSrc('');
        }
    },
    
    createPreviewButton: function(){
        var me = this;
        var parent = me.browseButtonWrap ? me.browseButtonWrap : me.bodyEl;
        me.buttonPreview = Ext.widget('button', Ext.apply({
            ui:             me.ui,
            renderTo:       parent,
            text:           me.buttonPreviewText,
            cls:            Ext.baseCSSPrefix + 'form-file-btn',
            preventDefault: true,
            disabled:       true,
            style:          'margin-left:' + (me.buttonPreviewMargin-1) + 'px',
            handler:        me.showPreview,
            scope:          me
        }, me.buttonPreviewConfig));

    },
    
    showPreview: function(btn, e){
    	var me = this;
    	/*
        try{
            var img = new Image(),
                style;
            img.src = this.getImageValue();
            if(400 / img.width < 400 / img.height){
                style = 'style="max-width:100%"';
            }else{
                style = 'style="max-height:100%"';
            }
        }catch(err){}
		*/
    	
        var reader = new FileReader();

        reader.onload = function (e) {

            var win = Ext.create('Ext.window.Window', {
                title:      me.buttonPreviewText,
                autoScroll : true,
                height:     400,
                width:      400,
                modal:      true,
                layout:     'fit',
                html: '<img id="img_preview_win" src="' + e.target.result + '" />', // ' + style + ' 
                tools: [{
                    type:   'maximize',
                    handler: function(event, toolEl, owner, tool){
                        win.toggleMaximize();
                    },
                    scope:  win
                }],
                listeners : {
                	show : function(_this) {
                		var imgSrc = Ext.get("img_preview_win");
                    	_this.setWidth(imgSrc.getWidth()+30 >= 800 ? 800 : (imgSrc.getWidth()+30) );
                    	_this.setHeight(imgSrc.getHeight()+50 >= 600 ? 600 : (imgSrc.getHeight()+50));
                	}
                }
            }).show();

        }

        reader.readAsDataURL( Ext.get(this.fileInputEl.id.replace(/inputEl/ , 'button-fileInputEl')).dom.files[0]);
        
        /*
        var win = Ext.create('Ext.window.Window', {
            title:      this.buttonPreviewText,
            height:     400,
            width:      400,
            modal:      true,
            layout:     'fit',
            html: '<img src="' + this.getImageValue() + '" ' + style + ' />',
            tools: [{
                type:   'maximize',
                handler: function(event, toolEl, owner, tool){
                    win.toggleMaximize();
                },
                scope:  win
            }]
        }).show();
        */
    },
    
    getImageValue: function(){
        return this.imageRootPath + this.getValue();
    },
    
    setRawValue: function(value){
        var me = this,
            buttonPreview = me.buttonPreview;

        if (buttonPreview && !Ext.isEmpty(value) && value != 'delete') {
            buttonPreview.enable();
        }
        
        if( value && Ext.getCmp(me.getId()+"_preview")) {
        	Ext.get(me.getId()+'_preview_text').setDisplayed(false);
        			
        	this.previeImage();
        }

        return me.callParent(arguments);
    },
    
    onDestroy: function(){
        Ext.destroyMembers(this, 'buttonPreview');
        this.callParent();
    },
    previeImage:function() {
    	var me = this;
        var reader = new FileReader();
        
        if( me.fileInputEl ) {
	        reader.onload = function (e) {
	    		var imgSrc = Ext.getCmp(me.getId()+"_preview");
	    		imgSrc.setSrc( e.target.result );
	        }
	
	        reader.readAsDataURL( Ext.get(me.fileInputEl.id.replace(/inputEl/ , 'button-fileInputEl')).dom.files[0]);    
        }
     }
});

/**
* @class Ext.ux.form.plugin.HtmlEditor
* @author Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* @docauthor Adrian Teodorescu (ateodorescu@gmail.com; http://www.mzsolutions.eu)
* @license [MIT][1]
* 
* @version 1.4
* 
* 
* Provides plugins for the HtmlEditor. Many thanks to [Shea Frederick][2] as I was inspired by his [work][3].
* 
* [1]: http://www.mzsolutions.eu/extjs/license.txt
* [2]: http://www.vinylfox.com
* [3]: http://www.vinylfox.com/plugin-set-for-additional-extjs-htmleditor-buttons/
* 
* The plugin buttons have tooltips defined in the {@link #buttonTips} property, but they are not
* enabled by default unless the global {@link Ext.tip.QuickTipManager} singleton is {@link Ext.tip.QuickTipManager#init initialized}.
*
* ### Changelog:
* 
* #### 28.08.2012 - v1.3
* 
* Benedikt Elser <boun@gmx.de> - Resurrect the table plugin.
* 
* #### 03.10.2012 - v1.4
* 
* - Updated the table insertion to allow strings to be translated to other languages;
* - New plugins: strikethrough and justify full;
* - Multiple toolbars
* 
* 
#Example usage:#
{@img Ext.ux.form.plugin.HtmlEditor.png Ext.ux.form.plugin.HtmlEditor plugins}
     var top = Ext.create('Ext.form.Panel', {
        frame:true,
        title:          'HtmlEditor plugins',
        bodyStyle:      'padding:5px 5px 0',
        width:          '80%',
        fieldDefaults: {
            labelAlign:     'top',
            msgTarget:      'side'
        },
        items: [{
            xtype:          'htmleditor',
            fieldLabel:     'Text editor',
            height:         300,
            plugins: [
                Ext.create('Ext.ux.form.plugin.HtmlEditor',{
                    enableAll:  true
                })
            ],
            anchor:         '100%'
        }],
        buttons: [{
            text: 'Save'
        },{
            text: 'Cancel'
        }]
    });
    top.render(document.body);
*/
Ext.define('Ext.ux.form.plugin.HtmlEditor', {
    mixins: {
        observable: 'Ext.util.Observable'
    },
    alternateClassName: 'Ext.form.plugin.HtmlEditor',
    requires: [
        'Ext.tip.QuickTipManager',
        'Ext.form.field.HtmlEditor'
    ],
    
    /**
     * @cfg {Array} tableBorderOptions
     * A nested array of value/display options to present to the user for table border style. Defaults to a simple list of 5 varrying border types.
     */
    tableBorderOptions: [['none', 'None'], ['1px solid #000', 'Sold Thin'], ['2px solid #000', 'Solid Thick'], ['1px dashed #000', 'Dashed'], ['1px dotted #000', 'Dotted']],
    /**
    * @cfg {Boolean} enableAll Enable all available plugins
    */
    enableAll:              false,
    /**
    * @cfg {Boolean} enableUndoRedo Enable "undo" and "redo" plugins
    */
    enableUndoRedo:         false,
    /**
    * @cfg {Boolean} enableRemoveHtml Enable the plugin "remove html" which is removing all html entities from the entire text
    */
    enableRemoveHtml:       false,
    /**
    * @cfg {Boolean} enableRemoveFormatting Enable "remove format" plugin
    */
    enableRemoveFormatting: false,
    /**
    * @cfg {Boolean} enableIndenting Enable "indent" and "outdent" plugins
    */
    enableIndenting:        false,
    /**
    * @cfg {Boolean} enableSmallLetters Enable "superscript" and "subscript" plugins
    */
    enableSmallLetters:     false,
    /**
    * @cfg {Boolean} enableHorizontalRule Enable "horizontal rule" plugin
    */
    enableHorizontalRule:   false,
    /**
    * @cfg {Boolean} enableSpecialChars Enable "special chars" plugin
    */
    enableSpecialChars:     false,
    /**
    * @cfg {Boolean} enableWordPaste Enable "word paste" plugin which is cleaning the pasted text that is coming from MS Word
    */
    enableWordPaste:        false,
    /**
    * @cfg {Boolean} enableFormatBlocks Enable "format blocks" plugin which allows to insert formatting tags.
    */
    enableFormatBlocks:     false,
    /**
    * @cfg {Boolean} defaultFormatBlock Set the default block format.
    */
    defaultFormatBlock:     'p',
    /**
    * @cfg {Boolean} enableInsertTable Enable "insert table" plugin which allows inserting tables at the cursor.
    */
    enableInsertTable:      false,
    /**
    * @cfg {Boolean} enableMultipleToolbars Use this if you want to use multiple toolbars instead of the 
    * original one full of buttons
    */
    enableMultipleToolbars:  true,
    /**
     * @cfg {Array} specialChars
     * An array of additional characters to display for user selection.  Uses numeric portion of the ASCII HTML Character Code only. For example, to use the Copyright symbol, which is &#169; we would just specify <tt>169</tt> (ie: <tt>specialChars:[169]</tt>).
     */
    specialChars: [],
    /**
     * @cfg {Array} charRange
     * Two numbers specifying a range of ASCII HTML Characters to display for user selection. Defaults to <tt>[160, 256]</tt>.
     */
    charRange: [160, 256],
    /**
     * @cfg {Array} listFormatBlocks Array of available format blocks.
     */
    listFormatBlocks: ["p", "h1", "h2", "h3", "h4", "h5", "h6", "address", "pre"],
    
    wordPasteEnabled:       false,
    toolbar:                null,
    
    constructor: function(config) {
        Ext.apply(this, config);
    },
        
    init: function(editor){
        var me = this;
        me.editor = editor;
        me.mon(editor, 'initialize', me.onInitialize, me);
        me.mon(editor, 'sync', me.updateToolbar, me);
        me.mon(editor, 'editmodechange', me.onEditorModeChanged, me);
    },
    
    onInitialize: function(){
        var me = this, undef,
            items = [],
            baseCSSPrefix = Ext.baseCSSPrefix,
            tipsEnabled = Ext.tip.QuickTipManager && Ext.tip.QuickTipManager.isEnabled();
        
        function btn(id, toggle, handler){
            return {
                itemId : id,
                cls : baseCSSPrefix + 'btn-icon',
                iconCls: baseCSSPrefix + 'edit-'+id,
                enableToggle:toggle !== false,
                scope: me,
                handler:handler||me.relayBtnCmd,
                clickEvent:'mousedown',
                tooltip: tipsEnabled ? me.buttonTips[id] || undef : undef,
                overflowText: me.buttonTips[id].title || undef,
                tabIndex:-1
            };
        }

        if(me.enableFormatBlocks || me.enableAll){
            var i, listFormatBlocks = new Array();
            for(i=0; i < me.listFormatBlocks.length; i++){
                listFormatBlocks.push({
                    value:      me.listFormatBlocks[i].toLowerCase(),
                    caption:    me.buttonTips.listFormatBlocks[me.listFormatBlocks[i]]
                });
            }
            formatBlockSelectItem = Ext.widget('component', {
                renderTpl: [
                    '<select class="{cls}">',
                        '<tpl for="formats">',
                            '<option value="<{value}>" <tpl if="values.toLowerCase()==parent.defaultFormatBlock"> selected</tpl>>{caption}</option>',
                        '</tpl>',
                    '</select>'
                ],
                renderData: {
                    cls:                    baseCSSPrefix + 'font-select',
                    formats:                listFormatBlocks,
                    defaultFormatBlock:     me.defaultFormatBlock
                },
                renderSelectors: {
                    selectEl: 'select'
                },
                onDisable: function() {
                    var selectEl = this.selectEl;
                    if (selectEl) {
                        selectEl.dom.disabled = true;
                    }
                    Ext.Component.superclass.onDisable.apply(this, arguments);
                },
                onEnable: function() {
                    var selectEl = this.selectEl;
                    if (selectEl) {
                        selectEl.dom.disabled = false;
                    }
                    Ext.Component.superclass.onEnable.apply(this, arguments);
                }
            });
            if(!me.enableMultipleToolbars){
                items.push('-');
            };
            items.push(
                formatBlockSelectItem, '-'
            );
        }
        
        //insert buttons between original items
        if(me.editor.enableFormat){
            me.editor.getToolbar().insert(me.editor.getToolbar().items.indexOfKey('underline')+1, btn('strikethrough'));
        }
        if(me.editor.enableAlignments){
            me.editor.getToolbar().insert(me.editor.getToolbar().items.indexOfKey('justifyright')+1, btn('justifyfull'));
        }
                
        if(me.enableUndoRedo || me.enableAll){
            items.push(btn('undo', false));
            items.push(btn('redo', false));
            items.push('-');
        }
        if(me.enableIndenting || me.enableAll){
            items.push(btn('indent', false));
            items.push(btn('outdent', false));
            items.push('-');
        }
        if(me.enableSmallLetters || me.enableAll){
            items.push(btn('superscript'));
            items.push(btn('subscript'));
            items.push('-');
        }
        if(me.enableInsertTable || me.enableAll){
            items.push(btn('inserttable', false, me.doInsertTable));
        }
        if(me.enableHorizontalRule || me.enableAll){
            items.push(btn('inserthorizontalrule', false));
        }
        if(me.enableSpecialChars || me.enableAll){
            items.push(btn('chars', false, me.doSpecialChars));
        }
        if(me.enableWordPaste || me.enableAll){
            items.push(btn('wordpaste', true, me.doWordPaste));
            me.wordPasteEnabled = true;
        }else{
            me.wordPasteEnabled = false;
        }
        if(me.enableRemoveHtml || me.enableAll){
            items.push(btn('removehtml', false, me.doRemoveHtml));
        }
        if(me.enableRemoveFormatting || me.enableAll){
            items.push(btn('removeformat', false));
        }
        
        if(items.length > 0){
            if(me.enableMultipleToolbars){
                //me.tt = me.editor.getToolbar().getEl().wrap({tag: 'div'});
                me.toolbar = new Ext.Toolbar({
                    renderTo:           Ext.getBody(),
                    border:             false,
                    enableOverflow:     true,
                    cls:                'x-html-editor-tb'
                });
                // move new toolbar after the original toolbar
                me.toolbar.getEl().insertAfter(me.editor.getToolbar().getEl());
                //me.editor.toolbar = tt;
                //me.toolbar.removeCls(['x-toolbar', 'x-toolbar-default', 'x-box-layout-ct']);
            }
            me.getToolbar().add(items);
            
            fn = Ext.Function.bind(me.onEditorEvent, me);
            Ext.EventManager.on(me.editor.getDoc(), {
                mousedown: fn,
                dblclick: fn,
                click: fn,
                keyup: fn,
                buffer:100
            });
            
            if(formatBlockSelectItem){
                me.formatBlockSelect = formatBlockSelectItem.selectEl;

                me.mon(me.formatBlockSelect, 'change', function(){
                    me.relayCmd('formatblock', me.formatBlockSelect.dom.value);
                    me.editor.deferFocus();
                });                
            }
            
        }
    },
    
    getToolbar: function(){
        return this.enableMultipleToolbars ? this.toolbar : this.editor.getToolbar();
    },
    
    onEditorModeChanged: function(editor, sourceEdit, eOpts){
        this.disableItems(sourceEdit);
    },

    disableItems: function(disabled) {
        var items = this.getToolbar().items.items,
            i,
            iLen  = items.length,
            item;

        for (i = 0; i < iLen; i++) {
            item = items[i];

            if (item.getItemId() !== 'sourceedit') {
                item.setDisabled(disabled);
            }
        }
    },
    
    onEditorEvent: function(e){
        var me = this,
            diffAt = 0;
        
        //me.updateToolbar();
        
        me.curLength = me.editor.getValue().length;
        me.currPos = me.getSelectionNodePos();
        me.currNode = me.getSelectionNode();
        
        if (e.ctrlKey) {
            var c = e.getCharCode();
            if (c > 0) {
                c = String.fromCharCode(c);
                if(c.toLowerCase() == 'v' && me.wordPasteEnabled){
                    me.cleanWordPaste();
                }
            }
        }
        
        me.lastLength = me.editor.getValue().length;
        me.lastValue = me.editor.getValue();
        me.lastPos = me.getSelectionNodePos();
        me.lastNode = me.getSelectionNode();

    },
    
    updateToolbar: function(){
        var me = this,
            btns, doc;
        
        if(me.editor.readOnly){
            return;
        }
        
        btns = Ext.Object.merge(me.getToolbar().items.map, me.editor.getToolbar().items.map);
        doc = me.editor.getDoc();
        
        function updateButtons() {
            Ext.Array.forEach(Ext.Array.toArray(arguments), function(name) {
                if(btns[name]){
                    btns[name].toggle(doc.queryCommandState(name));
                }
            });
        }
        
        if(me.enableSmallLetters || me.enableAll){
            updateButtons('superscript', 'subscript');
        }
        
        if(me.enableWordPaste || me.enableAll){
            btns['wordpaste'].toggle(me.wordPasteEnabled);
        }

        if(me.editor.enableFormat){
            updateButtons('strikethrough');
        }

        if(me.editor.enableAlignments){
            updateButtons('justifyleft', 'justifycenter', 'justifyright', 'justifyfull');
        }
        
        if(me.enableFormatBlocks || me.enableAll){
            this.checkSelectionFormatBlock();
        }
    },
    
    doRemoveHtml: function() {
        Ext.defer(function() {
            var me = this, newString;
            me.editor.focus();
            var tmp = document.createElement("DIV");
            tmp.innerHTML = me.editor.getValue();
            newString = tmp.textContent||tmp.innerText;
            newString  = newString.replace(/\n\n/g, "<br />").replace(/.*<!--.*-->/g,"");
            
            me.editor.setValue(newString);
        }, 10, this);
    },

    doInsertTable: function(){
		// Table language text
		var me = this, 
            showCellLocationText = false;

		if (!me.tableWindow){
		    me.tableWindow = new Ext.Window({
		        title:          me.buttonTips['table'].title,
		        closeAction:    'hide',
                modal:          true,
		        width:          '335px',
		        items: [{
		            itemId:     'insert-table',
		            xtype:      'form',
		            border:     false,
		            plain:      true,
		            bodyStyle:  'padding: 10px;',
		            labelWidth: '65px',
		            labelAlign: 'right',
                    defaults: {
                        anchor:     '100%'
                    },
		            items: [{
		                xtype:          'numberfield',
		                allowBlank:     false,
		                allowDecimals:  false,
		                fieldLabel:     me.buttonTips['table'].rows,
		                name:           'row'
		            }, {
		                xtype:          'numberfield',
		                allowBlank:     false,
		                allowDecimals:  false,
		                fieldLabel:     me.buttonTips['table'].columns,
		                name:           'col'
		            }, {
		                xtype:          'combo',
		                fieldLabel:     me.buttonTips['table'].border,
		                name:           'border',
		                forceSelection: true,
		                mode:           'local',
		                store: new Ext.data.ArrayStore({
		                    autoDestroy:    true,
		                    fields:         ['spec', 'val'],
		                    data:           me.tableBorderOptions
		                }),
		                triggerAction:  'all',
		                value:          'none',
		                displayField:   'val',
		                valueField:     'spec'
		            }]
		        }],
				buttons: [{
				    text: me.buttonTips['table'].insert,
				    handler: function(){
				        var frm = this.tableWindow.getComponent('insert-table').getForm();
				        if (frm.isValid()) {
				            var border = frm.findField('border').getValue();
				            var rowcol = [frm.findField('row').getValue(), frm.findField('col').getValue()];
				            if (rowcol.length == 2 && rowcol[0] > 0 && rowcol[1] > 0) {
				                var colwidth = Math.floor(100/rowcol[0]);
				                var html = "<table style='border-collapse: collapse'>";
				                var cellText = '&nbsp;';
				                for (var row = 0; row < rowcol[0]; row++) {
				                    html += "<tr>";
				                    for (var col = 0; col < rowcol[1]; col++) {
				                        html += "<td width='" + colwidth + "%' style='border: " + border + ";'>" + cellText + "</td>";
				                    }
				                    html += "</tr>";
				                }
				                html += "</table>";

								// Workaround, if the editor is currently not in focus
                                var before = this.editor.getValue();
                                this.editor.insertAtCursor(html);
                                var after = this.editor.getValue();
                                if (before==after) {       
                                    this.editor.setValue(before+html);
                                }
				            }
				            this.tableWindow.hide();
				        } else {
				            if (!frm.findField('row').isValid()){
				                frm.findField('row').getEl().frame();
				            } else if (!frm.findField('col').isValid()){
				                frm.findField('col').getEl().frame();
				            }
				        }
				    },
				    scope: this
				}, {
				    text: me.buttonTips['table'].cancel,
				    handler: function(){
				        this.tableWindow.hide();
				    },
				    scope: this
				}]
		    }).show();
		} else {
            this.tableWindow.down('form').getForm().reset();
			this.tableWindow.show();
		}
    },
    
    doSpecialChars: function(){
        var specialChars = [];
        if (this.specialChars.length) {
            Ext.each(this.specialChars, function(c, i){
                specialChars[i] = ['&#' + c + ';'];
            }, this);
        }
        for (i = this.charRange[0]; i < this.charRange[1]; i++) {
            specialChars.push(['&#' + i + ';']);
        }
        var charStore = new Ext.data.ArrayStore({
            fields: ['char'],
            data: specialChars
        });
        this.charWindow = Ext.create('Ext.Window', {
            title:          this.buttonTips.chars.text,
            width:          '436px',
            autoHeight:     true,
            modal:          true,
            layout:         'fit',
            items: [{
                itemId:         'idDataView',
                xtype:          'dataview',
                store:          charStore,
                autoHeight:     true,
                multiSelect:    true,
                tpl: new Ext.XTemplate('<tpl for="."><div class="char-item">{char}</div></tpl><div class="x-clear"></div>'),
                overItemCls:    'char-over',
                trackOver:      true,
                itemSelector:   'div.char-item',
                listeners: {
                    itemdblclick: function(t, i, n, e){
                        this.editor.insertAtCursor(i.get('char'));
                        this.charWindow.close();
                    },
                    scope: this
                }
            }],
            buttons: [{
                text: 'Insert',
                handler: function(){
                    Ext.each(this.charWindow.down('#idDataView').selModel.getSelection(), function(rec){
                        var c = rec.get('char');
                        this.editor.focus();
                        this.editor.insertAtCursor(c);
                    }, this);
                    this.charWindow.close();
                },
                scope: this
            }, {
                text: 'Cancel',
                handler: function(){
                    this.charWindow.close();
                },
                scope: this
            }]
        });
        this.charWindow.show();
    },
    
    doWordPaste: function(){
        this.wordPasteEnabled = !this.wordPasteEnabled;
    },
    
    cleanWordPaste: function(){
        var me = this, selection, range, temp;
        
        me.editor.suspendEvents();
        selection = me.getSelection();
        range = me.editor.getDoc().createRange();
        range.setStart(me.lastNode, me.lastPos);
        range.setEnd(me.currNode, me.currPos);
        selection.removeAllRanges();
        selection.addRange(range);

        temp = document.createElement("DIV");
        temp.appendChild(range.cloneContents());

        me.relayCmd('delete');
        me.editor.insertAtCursor(me.fixWordPaste(temp.innerHTML));
        
        me.editor.resumeEvents();        
    },
    
    fixWordPaste: function(wordPaste) {
        var tmp = document.createElement("DIV");
        tmp.innerHTML = wordPaste;
        var newString = tmp.textContent||tmp.innerText;
        // this next piece converts line breaks into break tags
        // and removes the seemingly endless crap code
        newString  = newString.replace(/\n\n/g, "<br />").replace(/.*<!--.*-->/g,"");

        return newString;        
        
    },

    getSelection: function(){
        if (this.editor.getWin().getSelection) {
            return this.editor.getWin().getSelection();
        } else if (this.editor.getDoc().getSelection) {
            return this.editor.getDoc().getSelection();
        } else if (this.editor.getDoc().selection) {
            return this.editor.getDoc().selection;
        }
    },
    
    getSelectionNode: function(){
        var currNode;
        if (this.editor.getWin().getSelection) {
            currNode = this.editor.getWin().getSelection().focusNode;
        } else if (this.editor.getDoc().getSelection) {
            currNode = this.editor.getDoc().getSelection().focusNode;
        } else if (this.editor.getDoc().selection) {
            currNode = this.editor.getDoc().selection.createRange().parentElement();
        }
        
        return currNode;
    },
    
    getSelectionNodePos: function(){
        return this.getSelection().getRangeAt(0).startOffset;
    },

    getSelectedNode: function(){
        try{
            if (this.editor.getWin().getSelection) {
                var currNode = this.editor.getWin().getSelection().focusNode;
            } else if (this.editor.getDoc().getSelection) {
                var currNode = this.editor.getDoc().getSelection().focusNode;
            } else if (this.editor.getDoc().selection) {
                var currNode = this.editor.getDoc().selection.createRange().parentElement();
            }
        }catch(err){}
        if(currNode){
            if(currNode.nodeName == "#text") currNode = currNode.parentNode;
        }
        return currNode;
    },
    
    checkSelectionFormatBlock: function(){
        currNode = this.getSelectedNode();
        var index = -1;
        try{
            var currTag = currNode;
            var prevTagName = currNode.tagName;
            if (prevTagName) prevTagName = prevTagName.toLowerCase();

            while(prevTagName != "html"){
                if (prevTagName == "paragraph"){
                    index = this.listFormatBlocks.indexOf('p')
                }else{
                    index = this.listFormatBlocks.indexOf(prevTagName);
                }
                if (index >= 0) break;
                
                currTag = currTag.parentNode;
                prevTagName = currTag.tagName;
                if (prevTagName) prevTagName = prevTagName.toLowerCase();
            }
        }catch(err){}

        this.formatBlockSelect.dom.selectedIndex = index;
        return index;
    },

    relayBtnCmd: function(btn){
        this.relayCmd(btn.getItemId());
    },
    
    relayCmd: function(cmd, value) {
        Ext.defer(function() {
            var me = this;
            me.editor.focus();
            me.editor.execCmd(cmd, value);
//            me.updateToolbar();
        }, 10, this);
    },

    buttonTips : {
        undo : {
            title: 'Undo',
            text: 'Undo the last action.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        redo : {
            title: 'Redo',
            text: 'Redo the last action.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        removehtml : {
            title: 'Remove html',
            text: 'Remove html from the entire text.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        removeformat : {
            title: 'Remove formatting',
            text: 'Remove formatting for the selected area.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        inserttable : {
            title: 'Insert table',
            text: 'Insert table at the cursor.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        indent : {
            title: 'Indent',
            text: 'Indent paragraph.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        outdent : {
            title: 'Outdent',
            text: 'Outdent paragraph.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        superscript : {
            title: 'Superscript',
            text: 'Change font size to superscript.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        subscript : {
            title: 'Subscript',
            text: 'Change font size to subscript.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        inserthorizontalrule : {
            title: 'Insert horizontal rule',
            text: 'Insert horizontal rule at the cursor.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        chars : {
            title: 'Special chars',
            text: 'Insert special characters.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        wordpaste : {
            title: 'Word paste',
            text: 'Clean the pasted text.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        images : {
            title: 'Images',
            text: 'Insert images.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        listFormatBlocks: {
            p:          "Paragraph", 
            h1:         "Header 1", 
            h2:         "Header 2", 
            h3:         "Header 3", 
            h4:         "Header 4", 
            h5:         "Header 5", 
            h6:         "Header 6", 
            address:    "Address", 
            pre:        "Formatted"
        },
        strikethrough: {
            title:  'Strikethrough',
            text:   'Strikethrough the selected text.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        justifyfull: {
            title:  'Justify text',
            text:   'Justify the selected text.',
            cls: Ext.baseCSSPrefix + 'html-editor-tip'
        },
        table: {
            title:      'Insert Table',
            insert:     'Insert',
            cancel:     'Cancel',
            rows:       'Rows',
            columns:    'Columns',
            border:     'Border'
        }
    }
    
})

/**
*   This override is required to make the formatBlock plugin to work in IE and WebKit browsers.
*   The default behaviour was to insert <br> tags when Enter was pressed. We have to let the browser insert a new paragraph
*	to be able to change the format.
*/
Ext.override(Ext.form.field.HtmlEditor, {
    /*childEls: [
        'iframeEl', 'textareaEl', 'toolbarsEl'
    ],
    initRenderData: function() {
        this.beforeSubTpl = '<div class="' + this.editorWrapCls + '"><div id="{id}-toolbarsEl">' + Ext.DomHelper.markup(this.toolbar.getRenderTree()) + '</div>';
        return Ext.applyIf(Ext.Component.superclass.initRenderData(), this.getLabelableRenderData());
    }*/
});

if(Ext.isIE || Ext.isWebKit){
    Ext.override(Ext.form.field.HtmlEditor, {
        fixKeys: function() { 
            if (Ext.isIE) {
                return function(e){
                    var me = this,
                        k = e.getKey(),
                        doc = me.getDoc(),
                        range, target;
                    if (k === e.TAB) {
                        e.stopEvent();
                        range = doc.selection.createRange();
                        if(range){
                            range.collapse(true);
                            range.pasteHTML('&nbsp;&nbsp;&nbsp;&nbsp;');
                            me.deferFocus();
                        }
                    }
                };
            }

            if (Ext.isOpera) {
                return function(e){
                    var me = this;
                    if (e.getKey() === e.TAB) {
                        e.stopEvent();
                        me.win.focus();
                        me.execCmd('InsertHTML','&nbsp;&nbsp;&nbsp;&nbsp;');
                        me.deferFocus();
                    }
                };
            }

            if (Ext.isWebKit) {
                return function(e){
                    var me = this,
                        k = e.getKey();
                    if (k === e.TAB) {
                        e.stopEvent();
                        me.execCmd('InsertText','\t');
                        me.deferFocus();
                    }
                };
            }

            return null; 
        }()
        
    })
}
