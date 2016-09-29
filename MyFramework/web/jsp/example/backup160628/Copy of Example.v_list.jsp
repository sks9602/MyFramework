<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>

<jun:body title="목록조회" pageIndex="<%= TAB_INDEX %>">
	<jun:form section="search"  button="조회,다운로드" action="/example/example.do?p_action_flag=aa">
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="W02" first="all"></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="W02" first="all"></jun:item_search>
		<jun:item_search  type="grid"  title="제목">
			<jun:grid action="/example/example.do" button="추가, 삭제" width="1000" page="10">
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:grid>
		</jun:item_search>
		<jun:item_search  type="grid"  title="제목">
			<jun:grid action="/example/example.do" button="추가, 삭제" width="1000" page="10">
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:grid>
		</jun:item_search>
	</jun:form>

	<jun:data>
		<jun:grid id="n1" action="/example/example.do" button="추가" width="1000" page="10">
			<jun:column title="성명" column="NAME" ></jun:column>
			<jun:column title="사번" column="MEMBER_NO" ></jun:column>
		</jun:grid>
		<jun:grid id="n2" action="/example/example.do" button="추가, 삭제" width="1000" page="10">
			<jun:column title="성명" column="NAME" ></jun:column>
			<jun:column title="사번" column="MEMBER_NO" ></jun:column>
		</jun:grid>
	</jun:data>


	<jun:form section="search"  button="조회,다운로드" action="/example/example.do?p_action_flag=aa">
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="W02" first="all"></jun:item_search>
		<jun:section title="섹션 E-mail">
			<jun:item_search  type="text"   name="mail" title="E-mail1"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail2"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail3"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail4"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
			<jun:item_search  type="radio"  name="color"  title="제목6"    groupCode="W02" first="all"></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
		</jun:section>
		<jun:item_search  type="text"   name="mail" title="---E-mail"       ></jun:item_search>
		<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="W02" first="all"></jun:item_search>
		<jun:item_search  type="grid"  title="제목">
			<jun:grid action="/example/example.do" button="추가, 삭제" width="1000" page="10">
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:grid>
		</jun:item_search>
		<jun:item_search  type="grid"  title="제목">
			<jun:grid action="/example/example.do" button="추가, 삭제" width="1000" page="10">
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:grid>
		</jun:item_search>
		<jun:section title="섹션 E-mail">
			<jun:item_search  type="text"   name="mail" title="E-mail4"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
			<jun:item_search  type="radio"  name="color"  title="제목6"    groupCode="W02" first="all"></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
		</jun:section>
		<jun:section title="섹션 E-mail">
			<jun:item_search  type="text"   name="mail" title="E-mail4"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
			<jun:item_search  type="radio"  name="color"  title="제목6"    groupCode="W02" first="all"></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail5"       ></jun:item_search>
		</jun:section>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="W02" first="all"></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
	</jun:form>

</jun:body>