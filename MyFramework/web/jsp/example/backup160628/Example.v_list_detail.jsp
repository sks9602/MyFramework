<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<%@ page import="project.jun.was.parameter.HoParameter" %>
<jun:function action="fs_click_list_detail" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	var detailPanel = Ext.getCmp('v_list_detail_data_detail');
	detailPanel.setWidth(800);
	detailPanel.expand();
</jun:function>

<jun:function action="목록" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:function action="조회" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:function action="검색" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:function action="초기화" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:function action="초기화2" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:function action="추가" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:function action="삭제" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>
<jun:body title="목록+상세 조회" pageIndex="<%= TAB_INDEX %>">
	<jun:form section="search" action="/example/example.do" button="목록,조회,검색"  gridId="grid" position="north">
		<jun:item_search  type="text"   name="" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="combo"  name="" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
		<jun:item_search  type="radio"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
		<jun:item_search  type="checkbox"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
		<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
	</jun:form>

	<jun:data><!-- layout :  vbox, tab -->
		<jun:grid id="grid" action="/example/example.do"  width="500" fields="Sample.selectTableList">
			<jun:columns>
				<jun:column title="이름" column="table_name" width="200" renderer="function" editor="link" >
						function (value, p, record){
							return Ext.String.format(
								"<div style=\"cursor:hand;\" onclick=\"fs_click_list_detail('{1}');\"><b>{0}</b></div>",
							value,
							record.data.table_name,
							// "{"+ arg.join(",")+"}",
							p );
						}
					</jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:columns>
		</jun:grid>
		<jun:data id="detail" collapse="right"  position="east" title="상세 정보 보기 Header">
			<jun:form action="/example/example.do" title="상세정보" button="초기화" id="dtl1">
				<jun:section title="섹션 E-mail">
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
				</jun:section>
				<jun:section title="섹션 COMBO">
					<jun:item_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:item_detail>
				</jun:section>
				<jun:item_detail  type="radio"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
				<jun:item_detail  type="checkbox"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
			</jun:form>

			<jun:form action="/example/example.do" title="상세정보" button="초기화2" id="dtl2"  position="south">
				<jun:section title="섹션 E-mail">
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
				</jun:section>
				<jun:section title="섹션 COMBO">
					<jun:item_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:item_detail>
					<jun:item_detail  type="grid"  title="제목">
						<jun:grid action="/example/example.do" width="500" height="200" button="추가,삭제"  id="id_1" fields="Sample.selectTableList" position="sub">
							<jun:columns>
								<jun:column title="성명" column="NAME" ></jun:column>
								<jun:column title="샘플" column="MEMBER_NO" ></jun:column>
							</jun:columns>
						</jun:grid>
					</jun:item_detail>
				</jun:section>
				<jun:item_detail  type="radio"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
				<jun:item_detail  type="checkbox"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
			</jun:form>
		</jun:data>
	</jun:data>
</jun:body>