<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:body title="상세내용" pageIndex="<%= TAB_INDEX %>">
	<jun:form action="/example/example.do" title="상세정보">
		<jun:item_detail  type="radio"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
		<jun:section title="섹션 E-mail">
			<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
			<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
		</jun:section>
		<jun:section title="섹션 COMBO">
			<jun:item_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:item_detail>
		</jun:section>
		<jun:item_detail  type="checkbox"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
		<jun:item_detail  type="hidden"   name="p_action_flag" title="E-mail"  value='v_detail'      ></jun:item_detail>

		<jun:item_detail  type="grid"  title="제목">
			<jun:grid action="/example/example.do" width="500" height="200" >
				<jun:button section="button"  action="추가,삭제"></jun:button>
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="샘플" column="MEMBER_NO" ></jun:column>
			</jun:grid>
		</jun:item_detail>

		<jun:item_detail  type="grid"  title="제목2">
			<jun:grid action="/example/example.do" width="500" height="100" >
				<jun:button section="button"  action="저장"></jun:button>
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="샘플" column="MEMBER_NO" ></jun:column>
			</jun:grid>
		</jun:item_detail>

		<jun:button section="button" action="저장,삭제"></jun:button>
	</jun:form>
</jun:body>
