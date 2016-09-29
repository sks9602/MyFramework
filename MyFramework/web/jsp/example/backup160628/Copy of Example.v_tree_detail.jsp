<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:body title="트리+상세 조회" pageIndex="<%= TAB_INDEX %>">
	<jun:data><!-- layout :  vbox, tab -->
		<jun:tree action="/example/example.do">
			<jun:column title="성명" column="NAME" ></jun:column>
			<jun:column title="사번" column="MEMBER_NO" ></jun:column>
		</jun:tree>
		<jun:data position="east">
			<jun:form action="/example/example.do" title="상세정보" button="초기화" id="dtl_1" position="north">
				<jun:section title="섹션 E-mail">
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
				</jun:section>
				<jun:section title="섹션 COMBO">
					<jun:item_detail  type="combo"  name="title" title="타이틀"  groupCode="B02" first="none"></jun:item_detail>
					<jun:item_detail  type="label"  name="table_name" title="테이블 명"  ></jun:item_detail>
				</jun:section>
				<jun:item_detail  type="radio"  name="color" title="Favorite Color aaa"    groupCode="W02" first="all"></jun:item_detail>
				<jun:item_detail  type="checkbox"  name="animal" title="제목"    groupCode="W02" first="all"></jun:item_detail>
				<jun:item_detail  type="file"  name="file" title="파일"  ></jun:item_detail>
			</jun:form>

			<jun:form action="/example/example.do" title="상세정보" button="초기화2" position="south">
				<jun:section title="섹션 E-mail">
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
					<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
				</jun:section>
				<jun:section title="섹션 COMBO">
					<jun:item_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:item_detail>
					<jun:item_detail  type="grid"  title="제목">
						<jun:grid action="/example/example.do" width="500" height="200" button="추가,삭제"  id="id_1" fields="Sample.selectTableList">
							<jun:column title="성명" column="NAME" ></jun:column>
							<jun:column title="샘플" column="MEMBER_NO" ></jun:column>
						</jun:grid>
					</jun:item_detail>
				</jun:section>
				<jun:item_detail  type="radio"  name="color" title="Favorite Color aaa"    groupCode="W02" first="all"></jun:item_detail>
				<jun:item_detail  type="checkbox"  name="ani" title="제목"    groupCode="W02" first="all"></jun:item_detail>
			</jun:form>
		</jun:data>
	</jun:data>
</jun:body>