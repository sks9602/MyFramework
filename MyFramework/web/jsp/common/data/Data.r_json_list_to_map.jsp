
<%@ page
	contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	session="true"
	import="java.util.*"
	import="java.sql.Types"
	import="project.jun.dao.result.HoList"
	import="project.jun.delegate.HoDelegate"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoFormatter"
	import="org.apache.ibatis.metadata.result.MetaData"
%><%@include file="/jsp/common/include/include.jsp"
%><%
	
	HoSetHasMap CODE_SET_MAP = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_CODE_SET);
	HoSetHasMap COLUMN_SET_MAP = (HoSetHasMap) cache.get(HoCacheAdvice.CACHED_COLUMN_SET);


	boolean scriptTag = false;
	String cb = param.get("callback");
	if (!cb.equals("")) {
	    scriptTag = true;
	    response.setContentType("text/javascript");
	    response.setHeader("Content-Type", "charset=utf-8");
	} else {
	    response.setContentType("application/x-json");
	    response.setHeader("Content-Type", "charset=utf-8");
	}
	if (scriptTag) {
	    out.write(cb + "(");
	}

	long cnt = model.getLong(HoDelegate.KEY_JSON_CNT);

	HoList list = model.getHoList(HoDelegate.KEY_JSON_DATA);

	list.setDisplayFormat(hoCfg.getDisplayFormat());
	
	MetaData md = (list!=null ? list.getMetaData() : null );
	
	String keyCol = model.getString( "KEY_COL" );
	String valCol = model.getString( "VAL_COL" );


%>{"totalCount":"<%= cnt %>",
	"datas":[{<%
				
				for( int i=0 ; list != null && i<list.size() ; i++ ) {
					out.write("\r\n");
					if( i!=0 ) { 
						out.write(","); 
					} 
					
					out.write("\"" + list.getString(i, keyCol ) + "\" : ");
					
					boolean isSingleValue = list.getString(i, "IS_SINGLE_VAL" ).equals("Y");
					
					if( isSingleValue ) {
						out.write( "\"" + HoUtil.toJsonString(list.getString(i, valCol )).replaceAll("\r\n","") + "\""   );
					} else {
						out.write( HoUtil.toJsonString(list.getString(i, valCol )).replaceAll("\r\n","").replaceAll("#","\"")  );
						
					}
					
				} %>
			}]
	}
<%
if (scriptTag) {
    out.write(");");
}
%>
