<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:body title="목록+상세 조회" pageIndex="<%= TAB_INDEX %>">
	<jun:form section="search" action="/example/example.do">
		<jun:item_search  type="text"   name="" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="combo"  name="" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
		<jun:item_search  type="radio"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
		<jun:item_search  type="checkbox"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
		<jun:button section="button" action="목록,조회,검색"></jun:button>
	</jun:form>

	<jun:button section="button"></jun:button>

	<jun:data layout="hbox"><!-- layout :  vbox, tab -->
		<jun:data_section>
			<jun:grid action="/example/example.do">
				<jun:button section="button"></jun:button>
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:grid>
			<jun:data layout="vbox">
				<jun:form action="/example/example.do" title="상세정보">
					<jun:section title="섹션 E-mail">
						<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
						<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
					</jun:section>
					<jun:section title="섹션 COMBO">
						<jun:item_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:item_detail>
					</jun:section>
					<jun:item_detail  type="radio"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
					<jun:item_detail  type="checkbox"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
					<jun:button section="button"  action="초기화"></jun:button>
				</jun:form>

				<jun:form action="/example/example.do" title="상세정보">
					<jun:section title="섹션 E-mail">
						<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
						<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
					</jun:section>
					<jun:section title="섹션 COMBO">
						<jun:item_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:item_detail>
					</jun:section>
					<jun:item_detail  type="radio"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
					<jun:item_detail  type="checkbox"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
					<jun:button section="button"  action="초기화2"></jun:button>
				</jun:form>
			</jun:data>
		</jun:data_section>
	</jun:data>
</jun:body>