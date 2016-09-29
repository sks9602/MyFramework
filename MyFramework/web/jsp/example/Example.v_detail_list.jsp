<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%><%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:functions  targetId="detail_1">
	<jun:function action="저장" args=" table_name">
	var detail_1 = Ext.getCmp('v_detail_list_detail_detail_1');
	detail_1.submit({}) ;
	</jun:function>
	
	<jun:function action="삭제" args=" table_name" url="/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>

</jun:functions>

<jun:functions  targetId="detail_grid_1">
	<jun:function action="추가" args=" table_name">
	</jun:function>
	
	<jun:function action="삭제" args=" table_name" url="/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>
</jun:functions>

<jun:functions  targetId="detail_grid_2">
	<jun:function action="저장" args=" table_name">
	</jun:function>
</jun:functions>

<jun:functions  targetId="grid_1">
	<jun:function action="추가" args=" table_name">
	</jun:function>
</jun:functions>


<jun:body title="상세+목록" pageIndex="<%= TAB_INDEX %>">
	<jun:data >
		<jun:form action="/example/example.do" title="상세정보" id="detail_1" button="저장,삭제" maxItem="4">
			<jun:itemCode  type="radio"  name="Title" title="제목"    groupCode="SYS003" colspan="2" require="Y"></jun:itemCode>
			<jun:itemHtml  type="display"  value="상세정보 상세정보 상세정보 상세정보 상세정보" colspan="2" isAlert="Y"></jun:itemHtml>
			<jun:section title="섹션 E-mail">
				<jun:itemText  type="text"   name="email"   title="E-mail"  colspan="2" width="522" ></jun:itemText>
				<jun:itemText  type="text"   name="phone"   title="Phone"                ></jun:itemText>
				<jun:itemText  type="text"   name="fax"     title="fax"                  ></jun:itemText>
				<jun:itemText  type="text"   name="mobile"  title="mobile"               ></jun:itemText>
				<jun:itemText  type="text"   name="mobile1" title="mobile1"              ></jun:itemText>
			</jun:section>
			<jun:section title="섹션 COMBO">
				<jun:itemCode  type="combo"  name="Title2" title="타이틀"  groupCode="SYS002" first="none"></jun:itemCode>
			</jun:section>
			<jun:itemCode  type="checkbox"  name="Title3" title="제목2"    groupCode="SYS005" first="all"  colspan="4" require="Y"></jun:itemCode>
			<jun:itemFile  type="image"  name="image" title="이미지"    colspan="4" preview="Y"></jun:itemFile>
			<jun:itemFile  type="file"  name="file" title="파일"    colspan="4"></jun:itemFile>
			<jun:itemText  type="hidden"    name="p_action_flag" title="E-mail"  value="r_list_data"      ></jun:itemText>

			<jun:itemGrid  type="grid"  title="Grid 제목" require="Y" id="detail_grid_1" action="/example/example.do" width="600" height="200" pageYn="N"  button="추가,삭제"  fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="성명" column="NAME1"      ></jun:column>
					<jun:column title="샘플" column="MEMBER_NO1" ></jun:column>
				</jun:columns> 
			</jun:itemGrid>
			
			<jun:itemCode  type="checkbox"  name="Title4" title="제목4"    groupCode="SYS002" first="all"  colspan="4" require="Y"></jun:itemCode>
			
			<jun:itemGrid  type="grid"  title="Grid 제목2" id="detail_grid_2" action="/example/example.do" width="600" height="200" pageYn="N"  button="저장"  fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="성명" column="NAME2"      ></jun:column>
					<jun:column title="샘플" column="MEMBER_NO2" ></jun:column>
				</jun:columns> 
			</jun:itemGrid>
		</jun:form>


		<jun:grid id="grid_1" action="/example/example.do" button="추가" width="250" page="10" position="east"  fields="Sample.selectTableList">
			<jun:columns>
				<jun:column title="성명" column="NAME"      ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:columns>
		</jun:grid>
	</jun:data>


</jun:body>
