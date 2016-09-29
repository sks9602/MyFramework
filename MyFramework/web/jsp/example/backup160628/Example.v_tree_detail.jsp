<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>



<jun:function action="Toggle" args=" table_name"  fields="Sample.selectTableInfo">
	var cbW20 = Ext.getCmp('v_tree_detail_dtl_1_cbW20');
	var comboL20 = Ext.getCmp('v_tree_detail_dtl_1_comboL20');
	var section = Ext.getCmp('v_tree_detail_dtl_1_section섹션 COMBO');
	
	cbW20.setVisible(!cbW20.isVisible());
	comboL20.setVisible(!comboL20.isVisible());
	section.toggle();
	
	var cmps = cbW20.query('[isCheckbox]');
	for( var i=0;i < cmps.length; i++ ) {
		// alert( cmps[i].getValue() );
	}
</jun:function>
<jun:function action="초기화" args=" table_name"  fields="Sample.selectTableInfo">

	var store1 = Ext.getStore('v_tree_detail_store_grid_id_1'); 
	store1.load({params: {'p_action_flag':'r_list_data' } });
	var store = Ext.getStore('v_tree_detail_store_grid_id_2'); 
	store.load({params: {'p_action_flag':'r_list_data' } });
</jun:function>

<jun:function action="트리추가" args=" table_name">

	var tree = Ext.getCmp('v_tree_detail_tree_');

	var store = tree.getStore();
	var node = tree.getSelectionModel().getSelection();

	if( node && node.length > 0 ) {
		// alert(node[0].data.text + ":" + node[0].data.id);
		var t_node = store.getNodeById(node[0].data.id);

		var field = Ext.getCmp('v_tree_detail_dtl_1_title'), title;
		if( field.validate() ) {

			// 노드  leaf에서 branch로 변경
			if( node[0].get('leaf') ) {
				node[0].set('leaf', false); 
			}

			title = field.getValue();

			// 노드 추가
			var ran = Math.round(Math.random()*10000000);

			t_node.appendChild({
		        id: 'gc_'+ran,
		        text: title||'* No Title',
		        'value' : ran,
		        name: title||'* No Title',
		        leaf: true
			}, true);

			t_node.expand();
		} else {
			field.el.frame('red', 1, 0.2).frame('red', 1, 0.2);
		}
	} else {
		tree.el.frame('red', 1, 0.2).frame('red', 1, 0.2); 
		hoAlert('Node를 선택하세요.', Ext.exptyFn, 2000);
		// hoAlert('Node를 선택하세요.', function()  {  tree.el.frame('red', 1, 0.2).frame('red', 1, 0.2);  }, 2000);
	}
</jun:function>

<jun:function action="저장" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	var form = Ext.getCmp('v_tree_detail_detail_dtl_2');
	/*
	
	var grid, store, records, params = {};
	for( var i=0; i < form.query('grid').length ; i++ ) {
		grid = form.query('grid')[i];
		store = grid.getStore();
		
		// records = store.getModifiedRecords();
		records = store.getRange(0, store.getCount( ) );
		
		if( !records || records.length == 0 ) {
			continue;
		}
		var keys = [];

		for(var key =0; key< records[0].fields.length; key++){
			keys.push(records[0].fields.get(key)['name'] );
		}
		for(var k=0;k < keys.length;k++){
			params[keys[k]] = [];
			for(var j=0;j < records.length;j++){
				params[keys[k]].push(records[j].get(keys[k]));
			}
		}  
	}

	form.submit({params : params });
	*/
		
	form.submit({'msgTxt' : '저장하시겠습니가????'});	
</jun:function>

<jun:function action="상세정보 저장" args=" table_name">
	var form = Ext.getCmp('v_tree_detail_detail_dtl_1');

		
	form.submit();	
</jun:function>

<jun:function action="추가" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
alert( 'Example.v_tree_detail.jsp -> 추가');
</jun:function>

<jun:function action="삭제" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
alert( 'Example.v_tree_detail.jsp -> 삭제');
</jun:function>

<jun:body title="트리+상세 조회" pageIndex="<%= TAB_INDEX %>">
	<jun:data><!-- layout :  vbox, tab -->
		<jun:tree action="/example/example.do" position="west" title="Simple Ajax Tree">
			<jun:gridViewConfig>
				viewConfig: {
					listeners: {
							containercontextmenu : function(view, e, eOpts ) {
								e.stopEvent();
								var items = new Array;
			                    
			                    var tree = Ext.getCmp('v_tree_detail_tree_');
								var t_node = tree.getRootNode();
								
			                    items.push(Ext.create('Ext.Action', {
													        iconCls : 'btn-icon-tree-add-first-level',
													        text: '1단계 추가',
													        handler: function(widget, event) {
													        	var ran = Math.round(Math.random()*10000000);
											          			t_node.appendChild({
															        id: 'gc_'+ran,
															        text: '* No Title',
															        value : ran,
															        name: '* No Title',
															        leaf: true
																});  
													        }
													    }));
													    
								var contextMenu = Ext.create('Ext.menu.Menu', {
											        items: items
												});
								contextMenu.showAt(e.getXY());
								return false;
								
							},
			                itemcontextmenu : function(view, rec, item, index, e) {
			                    e.stopEvent();

								var tree = Ext.getCmp('v_tree_detail_tree_');
								var store = tree.getStore( );
								var t_node = store.getNodeById(rec.get('id'));
			                    
			                    var items = new Array;
			                    
			                    items.push(Ext.create('Ext.Action', {
													        iconCls : 'btn-icon-tree-add-sibling',
													        text: '같은 레벨 추가',
													        disabled : !(t_node.getDepth() < 3),
													        handler: function(widget, event) {
													            
													        }
													    }));
			                    items.push(Ext.create('Ext.Action', {
													        iconCls : 'btn-icon-tree-add-child',
													        text: '하위 레벨 추가',
													        disabled : !(t_node.getDepth() < 2),
													        handler: function(widget, event) {
													            
													        }
													    }));
			                    items.push('-');
			                    items.push(Ext.create('Ext.Action', {
													        iconCls : 'btn-icon-tree-delete',
													        text: '삭제',
													        handler: function(widget, event) {
													            
													        }
													    }));
			                    items.push(Ext.create('Ext.Action', {
													        iconCls : 'btn-icon-tree-delete-child',
													        text: '하위 트리 삭제',
													        disabled : (t_node.getDepth() >= 2),
													        handler: function(widget, event) {
													            
													        }
													    }));
								items.push('-');			                    
								items.push(Ext.create('Ext.Action', {
													        iconCls : 'btn-icon-expand',
													        text: 'Expand this tree',
													        disabled : t_node.isLeaf()||!t_node.hasChildNodes()||t_node.isExpanded(),
													        handler: function(widget, event) {
													            if (rec) {
													            
													                t_node.expand(true);
													            }
													        }
													    }));
			                    items.push(Ext.create('Ext.Action', {
													        iconCls : 'btn-icon-collapse',
													        text: 'Collapse this tree',
													        disabled : t_node.isLeaf()||!t_node.hasChildNodes()||!t_node.isExpanded(),
													        handler: function(widget, event) {
													            if (rec) {
													                t_node.collapse(true);
													            }
													        }
													    }));
													    
			                    
			                	var contextMenu = Ext.create('Ext.menu.Menu', {
											        items: items
												});
								contextMenu.showAt(e.getXY());
								return false;
			                }
			            }
			    },
			</jun:gridViewConfig>
		</jun:tree>

		<jun:data><!-- layout :  vbox, tab -->
			<jun:form action="/example/example.do" title="상세정보" button="상세정보 저장,초기화,Toggle,트리추가" id="dtl_1" position="center">
				<jun:item_detail  type="hidden"                 name="p_action_flag"  value="r_list_data" ></jun:item_detail>
				<jun:item_detail  type="text"    title="Title"  name="title"          value=""  require="Y" ></jun:item_detail>
				<jun:item_detail  type="passsword"   name="passsword" title="Password"  value=''      ></jun:item_detail>
				<jun:section title="섹션 E-mail">
					<jun:item_detail  type="text"   name="mail1" title="E-mail"       ></jun:item_detail>
					<jun:item_detail  type="text"   name="mail2" title="E-mail"       ></jun:item_detail>
				</jun:section>
				<jun:section title="섹션 COMBO">
					<jun:item_detail  type="combo"  name="title" title="타이틀"  groupCode="B02" first="none" id="comboL20"></jun:item_detail>
					<jun:item_detail  type="label"  name="table_name" title="테이블 명"  value="* 선택되지 않았습니다." ></jun:item_detail>
				</jun:section>
				<jun:item_detail  type="radio"  name="color" title="Favorite Color"    groupCode="W02" first="all"></jun:item_detail>
				<jun:item_detail  type="checkbox"  name="animal" title="제목"    groupCode="W02" first="all" id="cbW20"></jun:item_detail>
				<jun:item_detail  type="file"  name="file" title="파일" folder="sks" ></jun:item_detail>
				<jun:item_detail  type="file"  name="file" title="파일" folder="sks" ></jun:item_detail>
				<jun:item_detail  type="toggle"  name="toggle" title="토글"    groupCode="W02" first="all"></jun:item_detail>
				<jun:append>
				,{
					html : 'tag - jun:append '
				},{
					xtype : 'progressbar'
					,width : 300
				}
				</jun:append>
			</jun:form>
			<jun:form action="/example/example.do" title="상세정보" button="저장" position="south" id="dtl_2">
				<jun:section title="섹션 E-mail">
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
				</jun:section>
				<jun:section title="섹션 COMBO">
					<jun:item_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none" require="Y"></jun:item_detail>
					<jun:item_detail  type="grid"  title="제목1">
						<jun:grid action="/example/example.do" width="500" height="200" page="1" button="추가,삭제" id="id_1" fields="Sample.selectTableList">
							<jun:columns>
								<jun:column title="성명" column="table_name" ></jun:column>
								<jun:column title="샘플" column="table_comments" ></jun:column>
								<jun:column title="트리" column="MEMBER_NO" ></jun:column>
							</jun:columns>
						</jun:grid>
					</jun:item_detail>
					<jun:item_detail  type="grid"  title="제목2">
						<jun:grid action="/example/example.do" width="500" height="200" page="1" button="추가,삭제" id="id_2" fields="Sample.selectTableList">
							<jun:columns>
								<jun:column title="성명" column="table_name" ></jun:column>
								<jun:column title="샘플" column="table_comments" ></jun:column>
								<jun:column title="트리" column="fax_number" ></jun:column>
							</jun:columns>
						</jun:grid>
					</jun:item_detail>
				</jun:section>
				<jun:item_detail  type="radio"  name="color" title="Favorite Color aaa aaaaaaa aaaa"    groupCode="W02" first="all"></jun:item_detail>
				<jun:item_detail  type="checkbox"  name="ani" title="제목"    groupCode="W02" first="all"></jun:item_detail>
			</jun:form>
		</jun:data>

	</jun:data>

</jun:body>