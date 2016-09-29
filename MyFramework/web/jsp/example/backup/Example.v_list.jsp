<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:button_event action="조회">
	// Ext.Msg.show({title : '버튼 호출..', msg : 'here', buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});

	hoConfirm('Are you sure you want to do that?', function(btn) {
		if( btn == 'yes' ) {
			if( this.up('form').getForm().isValid() ) {
				var param = getParam(this, 's_delete');

				Ext.Ajax.request({
	                                url: '/s/example/example.do',
	                                method: 'POST',
	                                params: param,
	                                success : function(response,options){
										hoMessage('성공..');
	                                },
	                                failure: function(){
	                                    hoError('오류발생');
	                                },
	                                scope: this
	                            });
			}
			// Ext.Msg.show({title : '버튼 호출..', msg : 'btn [' + btn +']' , buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});
		} else {
			// hoError('다운로드');
		}
	}, this );

</jun:button_event>

<jun:body title="목록조회" pageIndex="<%= TAB_INDEX %>">
	<jun:form section="search" action="/example/example.do?p_action_flag=aa">
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="combo"  name="title1" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
		<jun:item_search  type="combo"  name="title2" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
		<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="B20" first="all"></jun:item_search>
		<jun:item_search  type="checkbox"  name="animal" title="제목"    groupCode="B20" first="all"></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
		<jun:button section="button" action="조회,다운로드"></jun:button>
	</jun:form>

	<jun:button section="button"  action="다운로드"></jun:button>

	<jun:data layout="">
		<jun:grid action="/example/example.do" width="1000" page="10">
			<jun:button section="button"  action="추가"></jun:button>
			<jun:column title="성명" column="NAME" ></jun:column>
			<jun:column title="사번" column="MEMBER_NO" ></jun:column>
		</jun:grid>
	</jun:data>
</jun:body>