
<%@ page
	contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	session="true"
	import="java.util.*"
	import="java.sql.Types"
	import="project.jun.dao.result.HoList"
	import="project.jun.delegate.HoDelegate"
	import="project.jun.util.HoUtil"
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

	HoMap info = model.getHoMap(HoDelegate.KEY_JSON_DATA);
	HoList listSub = null;


	boolean hasBefore = false;
	MetaData md = (info!=null ? info.getMetaData() : null );

%>{"datas":[{
	<%
		out.write("\r\n  ");
		for( int j=0 ; j<md.getColumnCount() ; j++ ) {
			//System.out.println(WizUtil.toJsonString(list.getString(i, md.getColumnName(j))));
			
			if( j!=0 ){
				out.write(",");
			}

			if( model.get(HoDelegate.KEY_JSON_DATA+md.getColumnName(j)) != null) {
				listSub = model.getHoList(HoDelegate.KEY_JSON_DATA+md.getColumnName(j));
				out.write("\"" + md.getColumnName(j).toUpperCase() + "\" : [");

				for( int k=0 ; listSub != null && k<listSub.size() ; k++ ) {
					if( k!=0 ) {
						out.write( "," );
					}
					out.write( "\"" + HoUtil.toJsonString(listSub.getString(k, md.getColumnName(j)))+"\"");
				}
				out.write( "]");
			} else {
				out.write("\""+ md.getColumnName(j).toUpperCase()+"\" : ");
				out.write("\"");			
				out.write( md.getColumnType(j) == java.sql.Types.CLOB  ? HoUtil.toJsonString(HoUtil.getStringForCLOB((java.sql.Clob)info.get( md.getColumnName(j))).replaceAll("\r\n","").replaceAll("'","").replaceAll("\"","")) : HoUtil.toJsonString(info.getString( md.getColumnName(j)).replaceAll("\r\n","").replaceAll("'","")) );
				out.write("\"");
			}
		}
	%>	}]
	}
<%
if (scriptTag) {
    out.write(");");
}
%>
