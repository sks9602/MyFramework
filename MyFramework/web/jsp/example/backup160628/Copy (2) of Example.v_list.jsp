<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:function action="fs_클릭" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	fs_AddTab_v_tree_detail(args);


	Ext.getCmp('id_main_tabpanel').setActiveTab('v_tree_detail');
	/*
	for( var i in args) {
 		var tgt = Ext.DomQuery.select('div[id=v_tree_detail] *[name='+i+']');
 		for(var j=0; j< tgt.length ; j++ ) {
 			tgt[j].value = args[i];
 		}

	 	var tgt2 = Ext.DomQuery.select('div[id=v_tree_detail] *[id='+i+'_label]');

	 	for(var j=0; j< tgt2.length ; j++ ) {
			Ext.get(tgt2[j].id).update(args[i]);
	 	}
	}
	*/

	store.on("load", function(_this, _records, _successful, _eOpts ) {

		var form = Ext.getCmp('id_detail_v_tree_detail_dtl_1');
		//for( var i in  _records[0].data ) {
			// alert( i );
		//}
        form.loadRecord(_records[0]);
	});

</jun:function>

<jun:function action="조회" args=" table_name, comments">
	// Ext.Msg.show({title : '버튼 호출..', msg : 'here', buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});

	fs_AddTab_v_tree_detail();

	if( Ext.getCmp('v_list_list')) {
		fs_AddTab_v_detail_list();
	}

	if( Ext.getCmp('v_list_detail')) {
		fs_AddTab_v_list_list();
	}

	if( Ext.getCmp('v_detail')) {
		fs_AddTab_v_list_detail();
	}
	fs_AddTab_v_detail();

	hoConfirm('Are you sure you want to do that?', function(btn) {
		if( btn == 'yes' ) {
			if( this.up('form').getForm().isValid() ) {
				var param = getParam(this, 'b_insert');

				Ext.Ajax.request({
	                                url: '/s/example/example.do',
	                                method: 'POST',
	                                params: param,
	                                success : function(response,options){
										hoMessage('성공..');
	                                },
	                                failure: function(){
	                                	/*
										for( var x in arguments[0] ) {
											alert( arguments[0][x])
										}
										for( var x in arguments[1] ) {
											alert( arguments[1][x])
										}
										for( var x in arguments[2] ) {
											alert( arguments[2][x])
										}
										*/
	                                    hoError('오류');
	                                },
	                                scope: this
	                            });
			}
			// Ext.Msg.show({title : '버튼 호출..', msg : 'btn [' + btn +']' , buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});
		} else {
			// hoError('다운로드');
		}
	}, this );

</jun:function>


<jun:body title="목록조회" pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:form section="search"  button="조회,다운로드" action="/example/example.do" gridId="grid_1" position="north">
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
			<jun:item_search  type="combo"  name="title1" title="타이틀"  groupCode="B02" first="none"></jun:item_search>
			<jun:item_search  type="combo"  name="title2" title="타이틀"  groupCode="B02" first="none"></jun:item_search>
			<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="W02" first="all"></jun:item_search>
			<jun:item_search  type="checkbox"  name="animal" title="제목"    groupCode="W02" first="all"></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
			<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		</jun:form>

		<jun:grid id="grid_1" action="/example/example.do" button="추가" page="10" checkbox="Y" fields="Sample.selectTableList">
			<jun:column title="이름" column="table_name" locked="Y" renderer="function" editor="link" >
				function (value, p, record){
					/*
					var arg = [];
					for( var x in record.data ) {
						arg.push("'"+x+"' : "+ "'" + record.data[x]  +"'")
					}
					*/

					return Ext.String.format(
						"<div style=\"cursor:hand;\" onclick=\"fs_클릭('{1}');\"><b>{0}</b></div>",
					value,
					record.data.table_name,
					// "{"+ arg.join(",")+"}",
					p );
				}
			</jun:column>
			<jun:column title="설명" column="table_comments" flex="1" align="left" width="200" editor="textfield"></jun:column>
			<jun:column title="E-Mail" column="email" width="100" resize="N" sortable="N" editor="email" ></jun:column>
			<jun:column title="팩스" column="fax_number"  width="150" editor="numberfield, minValue:10, maxValue:100"  renderer="rowspanRenderer"></jun:column>
			<jun:columnGrp title="연락처">
				<jun:column title="전화번호" column="phone_number"  width="150"></jun:column>
				<jun:column title="휴대폰번호" column="hp_number"  width="150"></jun:column>
			</jun:columnGrp>
		</jun:grid>
	</jun:data>
</jun:body>