<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:functions  targetId="detail_1">
	<jun:function action="저장" args=" table_name">
	var detail_1 = Ext.getCmp('v_detail_detail_detail_1');
	detail_1.submit({}) ;
	</jun:function>
	
	<jun:function action="삭제" args=" table_name">
	</jun:function>
</jun:functions>

<jun:functions  targetId="detail_grid_1">
	<jun:function action="추가" args=" table_name">
	</jun:function>
	
	<jun:function action="삭제" args=" table_name">
	</jun:function>
</jun:functions>

<jun:functions  targetId="detail_grid_2">
	<jun:function action="저장" args=" table_name">
	</jun:function>
</jun:functions>

<jun:body title="상세내용" pageIndex="<%= TAB_INDEX %>">
	<jun:form id="detail_1" action="/example/example.do" title="상세정보" button="저장,삭제">
		<jun:itemText  type="hidden"   name="p_action_flag" title="E-mail"  value='v_detail'      ></jun:itemText>
		<jun:itemCode  type="radio"  name="radio1" title="라디오1"    groupCode="SYS001" first="all" colspan="4"></jun:itemCode>
		<jun:section title="섹션 E-mail">
			<jun:itemText  type="text"   name="email1" title="E-mail1"   vtype="email"     ></jun:itemText>
			<jun:itemText  type="text"   name="email2" title="E-mail2"   require="Y"     ></jun:itemText>
			<jun:itemText  type="text"   name="email3" title="E-mail3"       ></jun:itemText>
		</jun:section>
		<jun:section title="섹션 COMBO">
			<jun:itemCode  type="combo"  name="" title="타이틀"  groupCode="SYS002" ></jun:itemCode>
		</jun:section>
		<jun:itemCode  type="checkbox"  name="checkbox1" title="체크박스1"    groupCode="SYS003" first="all" colspan="4"></jun:itemCode>
		<jun:itemText  type="text"   name="text1" title="내용1"  value=""      ></jun:itemText>
		<jun:itemText  type="text"   name="text2" title="내용2"  value="내용2"      ></jun:itemText>
		<jun:itemText  type="passsword"   name="passsword" title="Password"  value='' colspan="2"  require="Y"  ></jun:itemText>
		<jun:itemText  type="textarea"   name="textarea1" title="긴내용1"  value=''   colspan="4"  require="Y"   ></jun:itemText>

		<jun:itemGrid  type="grid"  title="제목" action="/example/example.do" width="500" height="200" button="추가,삭제"  id="detail_grid_1" page="5" fields="Sample.selectTableList">
			<jun:columns>
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="샘플" column="MEMBER_NO" ></jun:column>
			</jun:columns> 
		</jun:itemGrid>

		<jun:itemGrid  type="grid"  title="제목2" action="/example/example.do" width="500" height="200"  button="저장"  id="detail_grid_2" page="5" fields="Sample.selectTableList">
			<jun:columns>
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="샘플" column="MEMBER_NO" ></jun:column>
			</jun:columns> 
		</jun:itemGrid>

	</jun:form>
</jun:body>
