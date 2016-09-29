<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:functions  targetId="form_1">

	<jun:function action="저장" args=" table_name" fields="Sample.selectTableInfo">
	alert( 'Example.v_tpl.jsp -> 저장');
	</jun:function>
	
	<jun:function action="삭제" args=" table_name" fields="Sample.selectTableInfo">
	alert( 'Example.v_tpl.jsp -> 삭제');
	</jun:function>
</jun:functions>


<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:grid id="grid_1" action="/example/example.do"  width="500" fields="Sample.selectTableList" editable="Y" position="west">
			<jun:columns>
				<jun:column title="학습일자" column="EDU_DT"  width="150" align="left" ></jun:column>
				<jun:column title="Combo Editor" column="email2" width="100" resize="N" sortable="N"  editor="combotipple" >
					<jun:columnCode type="combo" groupCode="SYS001"  ></jun:columnCode>
				</jun:column>
				<jun:columnGrp title="교시">
					<jun:column title="0교시" column="COLUMN_YN"  width="60"></jun:column>
					<jun:column title="8/9/10교시" column="OWNER"  width="100" ></jun:column>
				</jun:columnGrp>
			</jun:columns>
		</jun:grid>
				
		<jun:form id="form_1" action="/example/example.do" title="상세정보" button="저장,삭제" position="center">
		
		</jun:form>
	</jun:data>
</jun:body>