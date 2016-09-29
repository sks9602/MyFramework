<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:functions  targetId="tree_1">
	
</jun:functions>

<jun:functions  targetId="dtl_1">
	<jun:function action="상세정보 저장" args=" table_name">
	</jun:function>
	
	<jun:function action="초기화" args=" table_name">
	</jun:function>

	<jun:function action="Toggle" args=" table_name">
	</jun:function>
	
	<jun:function action="트리추가" args=" table_name">
	</jun:function>
</jun:functions>

<jun:functions  targetId="dtl_2">
	<jun:function action="저장" args=" table_name">
	</jun:function>
</jun:functions>

<jun:functions  targetId="dtl_id_1">
	<jun:function action="추가" args=" table_name">
	</jun:function>
	<jun:function action="삭제" args=" table_name">
	</jun:function>
</jun:functions>

<jun:functions  targetId="dtl_id_2">
	<jun:function action="추가" args=" table_name">
	</jun:function>
	<jun:function action="삭제" args=" table_name">
	</jun:function>
</jun:functions>

<jun:body title="트리+상세 조회" pageIndex="<%= TAB_INDEX %>">
	<jun:data><!-- layout :  vbox, tab -->
		<jun:tree id="tree_1" action="/example/example.do" position="west" title="Simple Ajax Tree">
			<jun:objects name="viewConfig">
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
			</jun:objects>
		</jun:tree>

		<jun:data><!-- layout :  vbox, tab -->
			<jun:form action="/example/example.do" title="상세정보" button="상세정보 저장,초기화,Toggle,트리추가" id="dtl_1" position="center" maxItem="2">
				<jun:itemText  type="hidden"                 name="p_action_flag"  value="r_list_data" ></jun:itemText>
				<jun:itemText  type="text"    title="OWNER"  name="OWNER"          value=""  require="Y" ></jun:itemText>
				<jun:itemText  type="passsword"   name="passsword" title="Password"  value=''      ></jun:itemText>
				<jun:section title="섹션 E-mail">
					<jun:itemText  type="text"   name="TNAME" title="TNAME"       ></jun:itemText>
					<jun:itemText  type="text"   name="mail2" title="E-mail"       ></jun:itemText>
				</jun:section>
				<jun:section title="섹션 COMBO">
					<jun:itemCode  type="combo"  name="title" title="타이틀"  groupCode="SYS001" first="none"></jun:itemCode>
					<jun:itemText  type="label"  name="table_name" title="테이블 명"  value="* 선택되지 않았습니다." ></jun:itemText>
				</jun:section>
				<jun:itemCode  type="radio"  name="color" title="Favorite Color"    groupCode="SYS002" first="all" colspan="2"></jun:itemCode>
				<jun:itemCode  type="checkbox"  name="animal" title="제목"    groupCode="SYS003" first="all"  colspan="2"></jun:itemCode>
				<jun:itemToggle  type="toggle"  name="toggle" title="토글"    ></jun:itemToggle>
				<jun:itemHtml  type="display" name="FORUPDATE" value="Text For Update "></jun:itemHtml>
				<jun:append>
				,{
					xtype : 'progressbar'
					,width : 300
				}
				</jun:append>
			</jun:form>
			<jun:form action="/example/example.do" title="상세정보" button="저장" position="south" id="dtl_2" maxItem="2">
				<jun:section title="섹션 E-mail">
					<jun:itemText  type="text"   name="mail3" title="E-mail3"       ></jun:itemText>
					<jun:itemText  type="text"   name="mail4" title="E-mail4"       ></jun:itemText>
				</jun:section>
				<jun:section title="섹션 COMBO">
					<jun:itemText  type="text"  name="title4" title="타이틀4" require="Y" colspan="2"></jun:itemText>
					<jun:itemGrid  type="grid"  title="제목1" action="/example/example.do" width="500" height="200" page="1" button="추가,삭제" id="dtl_id_1" fields="Sample.selectTableList">
						<jun:columns>
							<jun:column title="성명" column="table_name" ></jun:column>
							<jun:column title="샘플" column="table_comments" ></jun:column>
							<jun:column title="트리" column="MEMBER_NO" ></jun:column>
						</jun:columns> 
					</jun:itemGrid>
					<jun:itemGrid  type="grid"  title="제목2" action="/example/example.do" width="500" height="200" page="1" button="추가,삭제" id="dtl_id_2" fields="Sample.selectTableList">
						<jun:columns>
							<jun:column title="성명" column="table_name" ></jun:column>
							<jun:column title="샘플" column="table_comments" ></jun:column>
							<jun:column title="트리" column="fax_number" ></jun:column>
						</jun:columns>
					</jun:itemGrid>
				</jun:section>
				<jun:itemCode  type="radio"  name="color" title="Favorite Color"    groupCode="SYS004" first="all"></jun:itemCode>
				<jun:itemCode  type="checkbox"  name="ani" title="제목"    groupCode="SYS005" first="all"></jun:itemCode>
			</jun:form>
		</jun:data>

	</jun:data>

</jun:body>