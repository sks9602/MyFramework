
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

%>{"totalCount":"<%= cnt %>",
	"datas":[<%
				for( int i=0 ; list != null && i<list.size() ; i++ ) {
					out.write("\r\n");
					if( i!=0 ) { 
						out.write(","); 
					} 
					out.write("{");
					for( int j=0 ; j<md.getColumnCount() ; j++ ) {
						//System.out.println(WizUtil.toJsonString(list.getString(i, md.getColumnName(j))));
						if( j!=0 ) { 
							out.write(",");
						}
						out.write("\"" + md.getColumnName(j).toUpperCase() + "\" : ");
						out.write("\"" +(md.getColumnType(j) == java.sql.Types.CLOB  ? HoUtil.toJsonString(HoUtil.getStringForCLOB((java.sql.Clob)list.get(i, md.getColumnName(j))).replaceAll("\r\n","").replaceAll("'","").replaceAll("\"","")) : HoUtil.toJsonString(list.getString(i, md.getColumnName(j)).replaceAll("\r\n","").replaceAll("'","")))  + "\"");
					
						if( md.getColumnName(j).endsWith("_ES") ) {
							String [] values = list.getStringParts(i, md.getColumnName(j));
							for( int k=0 ; k<values.length ; k++) { 
								out.write(", \"" + (md.getColumnName(j).toUpperCase()+ "_"+k) + "\" : " );	
								out.write("\"" + HoUtil.toJsonString(values[k]) + "\"" );	
							}
						}
						if( md.getColumnType(j) == Types.TIMESTAMP ) {
							out.write(", \"" + md.getColumnName(j).toUpperCase() + "_DTL\" : " );	
							out.write("\"" + list.getDateTimeFormat(i, md.getColumnName(j)) + "\"" );	
						}
						else if( md.getColumnType(j) == Types.DATE ) {
							out.write(", \"" + md.getColumnName(j).toUpperCase() + "_YMD\" : " );	
							// out.write("\"" + list.getDateTimeFormat(i, md.getColumnName(j)) + "\"" );	
							out.write("\"" + HoFormatter.toDateTimeFormat(list.get(i, md.getColumnName(j)), hoCfg.getDisplayFormat())+ "\"" );	
							//out.write(", \"" + md.getColumnName(j).toUpperCase() + "_YMDHMS\" : " );	
							// out.write("\"" + list.getDateTimeFormat(i, md.getColumnName(j)) + "\"" );	
							//out.write("\"" + HoFormatter.toDateTimeFormat(list.get(i, md.getColumnName(j)), hoCfg.getDisplayFormat())+" "+ HoFormatter.toTimeFormat(list.get(i, md.getColumnName(j)), hoCfg.getDisplayFormat()) + "\"" );	
						}

						if( md.getColumnName(j).toUpperCase().endsWith("_CD")) {
							out.write(", \"" + md.getColumnName(j).toUpperCase() + "_NM\" : " );	
							out.write("\"" + CODE_SET_MAP.getString(list.getString(i, md.getColumnName(j)), "CD_NM") + "\"" );	
						} else if( md.getColumnName(j).toUpperCase().endsWith("_YN")) {
							out.write(", \"" + md.getColumnName(j).toUpperCase() + "_BOOL\" : " );	
							out.write( (list.getString(i, md.getColumnName(j)).equals("Y") ? "true" : "false") );	
						}
					}
					out.write("}");
				} %>
			]
	}
<%
if (scriptTag) {
    out.write(");");
}
%>
