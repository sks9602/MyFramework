<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="pjt.epolylms.util.HtmlUtil"
	import="java.util.HashMap"
	import="java.util.Map"
	import="java.util.List"
	import="systemwiz.jfw.sql.SqlHelper"
	import="systemwiz.jfw.jsp.SessionHelper"
	
%>
<%@ attribute name="area" type="java.lang.String" required="true" %> <%-- html / script / out_script 중 택1 --%>
<%@ attribute name="extName" type="java.lang.String"%><%--  확장자 명 --%>
<%@ attribute name="totalMaxSize" type="java.lang.String" %> <%--  총 파일 크기 (MB) --%>
<%@ attribute name="unitMaxSize" type="java.lang.String"  %><%--  단위 파일 크기  (MB) --%>
<%@ attribute name="maxFileCount" type="java.lang.String"  %><%--  총 파일 수 --%>
<%@ attribute name="width" type="java.lang.String"  %><%--  총 파일 수 --%>
<%@ attribute name="height" type="java.lang.String"  %><%--  총 파일 수 --%>
<%@ attribute name="name" type="java.lang.String" required="true" %><%--  총 파일 수 --%>
<%@ attribute name="form" type="java.lang.String" %>
<%@ attribute name="attachFileCode" type="java.lang.String" %>
<%@ attribute name="filePath" type="java.lang.String" required="true" %><%-- 파일 업로드 기본 경로 --%>
<%@ attribute name="preview" type="java.lang.String" %><%-- 미리보기 --%>

<% if( area.equalsIgnoreCase("html") ) { 
	maxFileCount = HtmlUtil.replaceNull( maxFileCount, "10");
	
	int maxFileCnt = 10;
	try {
		maxFileCnt = Integer.parseInt(maxFileCount);
	} catch(Exception e) {
		
	}
	
%>
<div id="id_innoDS_<%=form%>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>">	
	<div>
		<span id="id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_filePath"></span>
		<span id="id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_attachFileCode"></span>
		<span id="id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_fileParamInfo"></span>
		<span id="id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_fileParamInfoLength"></span>
	<%	for( int i=0 ;i<maxFileCnt; i++) { %>
		<span id="id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_<%=i%>"></span>
	<% } %>
	</div>	
</div>
<% if("Y".equals(HtmlUtil.replaceNull(preview))) { %>
<div style="float:left">
	<input type="button" value="Preview Image" onclick="fs_previewImg('<%= HtmlUtil.replaceNull(name, "InnoDS")%>')"/>
</div>
<% } %>
	<% if(  !"".equals(HtmlUtil.replaceNull( extName) ) ||  !"".equals(HtmlUtil.replaceNull( maxFileCount) )) { %>
<div>
	* <%if(  !"".equals(HtmlUtil.replaceNull( extName) ) ){ %>
	<%= extName %>
		<%if(  !"".equals(HtmlUtil.replaceNull( maxFileCount) ) ){ %>
		[<%= maxFileCount %>개]
		<% } %>
	확장자만 업로드 가능합니다.
	<% } else { %>	
		<%if(  !"".equals(HtmlUtil.replaceNull( maxFileCount) ) ){ %>
		<%= maxFileCount %>개의 파일 업로드 가능
		<% } %>
	<% }  %>
</div>
	<% }  %>
<% } else if( area.equalsIgnoreCase("script") ) { 
	maxFileCount = HtmlUtil.replaceNull( maxFileCount, "10");
	
	int maxFileCnt = 10;
	try {
		maxFileCnt = Integer.parseInt(maxFileCount);
	} catch(Exception e) {
		
	}
%>
	<% if(  !"".equals(HtmlUtil.replaceNull( extName) ) ) { %>
	fileExt['<%= HtmlUtil.replaceNull(name, "InnoDS")%>'] = "<%= extName %>";
	<% }  %>
	filePath['<%= HtmlUtil.replaceNull(name, "InnoDS")%>'] = filePath['<%= HtmlUtil.replaceNull(name, "InnoDS")%>']||'<%= HtmlUtil.replaceNull(filePath, "InnoDS")%>'
	fileObj.push('<%= HtmlUtil.replaceNull(name, "InnoDS")%>');
	fileObjUni['<%= HtmlUtil.replaceNull(name, "InnoDS")%>'] = fileObjUni['<%= HtmlUtil.replaceNull(name, "InnoDS")%>']||(Ext.Date.format(new Date, 'Ymd') + InnoDSGetUniqueID());
	fileUploaded['<%= HtmlUtil.replaceNull(name, "InnoDS")%>'] = false;
	<%-- 파일파라미터명 전송 파라미터 생성 --%>
	Ext.create('Ext.form.field.Hidden', {
		renderTo : 'id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_fileParamInfo',
		id : 'cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_fileParamInfo_hf',
		name : 'fileParamInfo',
		value : '<%= name %>'
	});
	<%-- 전송 파일의 경로 설정  --%>
	Ext.create('Ext.form.field.Hidden', {
		renderTo : 'id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_filePath',
		id : 'cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>FilePath_hf',
		name : '<%= HtmlUtil.replaceNull(name, "InnoDS")%>FilePath',
		value : '<%= HtmlUtil.replaceNull(filePath)%>/'+ fileObjUni['<%= HtmlUtil.replaceNull(name, "InnoDS")%>']
	});
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_fileParamInfo_hf');
    cmps['<%= form %>'].push('cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>FilePath_hf');
	
	// 첨부파일 관련 필드가 생성이 안된 경우
	<%-- 첨부파일번호(TB_SYE_ATTACHE_FILE.ATTACH_FILE_CODE) 전송 파라미터 생성 --%>
	Ext.create('Ext.form.field.Hidden', {
		renderTo : 'id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_attachFileCode',
		id : 'cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_attachFileCode_hf',
		name : '<%= HtmlUtil.replaceNull(name, "InnoDS")%>AttachFileCode',
		value : '<%= HtmlUtil.replaceNull(attachFileCode, "0")%>'
	});
	<%-- 업로드가능파일수 전송 파라미터 생성 --%>
	Ext.create('Ext.form.field.Hidden', {
		renderTo : 'id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_fileParamInfoLength',
		id : 'cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_fileParamInfoLength_hf',
		name : '<%= HtmlUtil.replaceNull(name, "InnoDS")%>FileParamInfoLength',
		value : '<%= maxFileCnt %>'
	});
	<%-- 전송을 위한 객체 정보 등록 --%>
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_fileParamInfoLength_hf');
    cmps['<%= form %>'].push('cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_attachFileCode_hf');
    
	<%	for( int i=0 ;i<maxFileCnt; i++) { %>
	Ext.create('Ext.form.field.Hidden', {
		renderTo : 'id_<%= form %>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_<%=i %>',
		id : 'cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_<%=i %>_hf',
		name : '<%= HtmlUtil.replaceNull(name, "InnoDS")%>_<%=i %>'
	});
	<%-- 전송을 위한 객체 정보 등록 --%>
	cmps['<%= form %>'] = cmps['<%= form %>']||[];    
    cmps['<%= form %>'].push('cmp_<%= HtmlUtil.replaceNull(name, "InnoDS")%>_<%=i %>_hf');
	<% } %>
<% } 
// html 또는 script가 아닌 경우
else {
	maxFileCount = HtmlUtil.replaceNull( maxFileCount, "10");
	
	int maxFileCnt = 10;
	try {
		maxFileCnt = Integer.parseInt(maxFileCount);
	} catch(Exception e) {
		
	}

%>
	<script type="text/javascript">
	
	Ext.onReady(function() {
		<%-- 파일 초기 정보 설정--%>
		<% if(  !"".equals(HtmlUtil.replaceNull( extName) ) ) { %>
		var LimitExt = "<%= extName %>";
		var ExtPermission = "true";
		<% } else {%>
		var ExtPermission = "false";
		<% } %>
		InnoDSInitMulti("<%=HtmlUtil.replaceNull( totalMaxSize, "10") %>MB", "<%=HtmlUtil.replaceNull( unitMaxSize, "10")%>MB", <%= maxFileCnt %>, <%=HtmlUtil.replaceNull(width, "500")%> , <%=HtmlUtil.replaceNull(height, "170")%>, "<%= HtmlUtil.replaceNull(name, "InnoDS")%>", "id_innoDS_<%=form%>_<%= HtmlUtil.replaceNull(name, "InnoDS")%>");
		<%-- 파일 upload directory설정 --%>
		fileObjUni['<%= HtmlUtil.replaceNull(name, "InnoDS")%>'] = fileObjUni['<%= HtmlUtil.replaceNull(name, "InnoDS")%>']||(Ext.Date.format(new Date, 'Ymd') + InnoDSGetUniqueID());

		<%
		if( !"0".equals(HtmlUtil.replaceNull(attachFileCode,"0"))) {
			SqlHelper sh = new SqlHelper();
			SessionHelper seh = new SessionHelper();
			seh.getSession(request, false);
			
			String HO_T_SYS_COMP = seh.get("S_COMP");
			String HO_T_SYS_LANG = seh.get("S_LANG");	
			String HO_T_SYS_MEMBER_NO = seh.get("S_MEMBER_NO");
			
			sh.setCompLangMember(S_COMP, HO_T_SYS_LANG, HO_T_SYS_MEMBER_NO);

			sh.query("com/AttachFile.sql", "selectAttachFileList", new String []{attachFileCode});
			int i=0;
		%>
			document.<%= HtmlUtil.replaceNull(name, "InnoDS")%>.AddTempFile("<%= sh.get("USER_FILE_NAME")%>", "<%= sh.get("FILE_SIZE")%>", "<%= sh.get("FILE_SEQ")%>");
		<% 

			// 저장된 파일 목록을 조회
			while(sh.next()) {
	%>
		document.<%= HtmlUtil.replaceNull(name, "InnoDS")%>.AddTempFile("<%= sh.get("USER_FILE_NAME")%>", "<%= sh.get("FILE_SIZE")%>", "<%= sh.get("FILE_SEQ")%>");
	<% 
				i++;
			}
			
			sh.close();
		}
	%>
	});
	
	</script>

<% } %>
