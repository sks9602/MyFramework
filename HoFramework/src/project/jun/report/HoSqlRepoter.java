package project.jun.report;

/*
 * SQL별로 사용된 TABLE정보와 DML구분과 해당 TABLE을 조회
 * 
 * 1. SqlMapConfig파일의 <mappers> element에 포함됨 xml을 이용해 해당 파일을 읽고
 * 2. 해당 sql xml파일에서 sql id를 조회 한후
 * 3. sql id별 sql을 parsing하여 쿼리에서 사용된 TABLE을 조회.
 * 
 */

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathFactory;

import org.apache.ibatis.parsing.XNode;
import org.apache.ibatis.parsing.XPathParser;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

public class HoSqlRepoter {

	private Document document;
	private XPath xpath;
	
	// 파일을 읽을 초기 경로..
	private String ROOT_DIR = "D:/Repository/Git/MyFramework/MyFramework/src/";
	
	public void setRootDir(String rootDir) {
		ROOT_DIR = rootDir;
	}
	
	/**
	 * SqlMapConfig 파일을 설정한다.. 
	 * 이건 사용자가 직접 설정 해주어야 함..
	 * @return
	 */
	public List<String> getSqlMapConfigFile() {
		List<String> files = new ArrayList<String>();
		
		files.add(ROOT_DIR + "com/base/sql/SqlMapConfig.xml");
		files.add(ROOT_DIR + "com/base/sql/SqlMapConfig_JDBC.xml");
		
		return files;
	}
	
	/**
	 * SqlMapConfig 파일에 설정된 sql xml파일의 전체 경로를   조회.
	 * 
	 * ex) return list of "D:/Repository/Git/MyFramework/MyFramework/src/com/base/sql/DBTable.xml"
	 * @return
	 */
	public List<String> getMapperResources() {
		List<String> sqlXmlList = new ArrayList<String>();

		List<String> sqlMapConfigFile = getSqlMapConfigFile();
		InputStream inputStream = null;

		try {
		

			for( int xi=0; xi<sqlMapConfigFile.size(); xi++ ) {
				inputStream = new FileInputStream( sqlMapConfigFile.get(xi) );
	
			
				XPathParser xpParser = new XPathParser(inputStream);
	
				List<XNode>  list = xpParser.evalNodes("/configuration/mappers/mapper");
				
				
				for( int i=0; i<list.size(); i++) {
					if( list.get(i).getStringAttribute("url") != null ) {
						sqlXmlList.add(list.get(i).getStringAttribute("url").replaceAll("file:////", ""));
						
						System.out.println(list.get(i).getStringAttribute("url").replaceAll("file:////", ""));
						
					} else {
						sqlXmlList.add(ROOT_DIR + list.get(i).getStringAttribute("resource"));
						
						System.out.println(ROOT_DIR + list.get(i).getStringAttribute("resource"));
					}
				}
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return sqlXmlList;
	}
	
	/**
	 * sql xml파일을 parsing해서 sqlId와 Node로 구성된 Map을 return한다.
	 * 
	 * ex) return map of key : nameSpace +"."+ sqlId+"_"+xpath, entry : SELECT * FROM 
	 *     { Combo.selectCodeInfo_/mapper/select[id='selectCodeInfo'], SELECT C.CODE, ~ FROM CODET C }
	 * @param sqlFileList
	 * @return
	 */
	public Map<String, XNode> getSqlIdNode( List<String> sqlFileList ) {
		Map<String, XNode> sqlIdMap = new HashMap<String, XNode>();
		
		InputStream inputStream = null;

		try {
		
			for( int xi = 0 ; xi<sqlFileList.size() ; xi++ ) {
				inputStream = new FileInputStream(sqlFileList.get(xi));
	
				XPathParser xpParser = new XPathParser(inputStream);
	
				List<XNode>  list = new ArrayList<XNode>();
					
				// paring대상 node
				String [] nodes = new String[] {"/mapper/select", "/mapper/update", "/mapper/insert", "/mapper/delete", "/mapper/call", "/mapper/sql"};

				XNode  nameSpaceNode = xpParser.evalNode("/mapper");
				String nameSpace = nameSpaceNode.evalString("@namespace");
				
				for( int ni=0 ; ni<nodes.length; ni++) {
					list = xpParser.evalNodes(nodes[ni]);
					
					for( int i=0; i<list.size(); i++) {
						// sqlXmlList.add(HoSqlRepoter.ROOT_DIR + list.get(i).getStringAttribute("id"));
					
						String sqlId = list.get(i).getStringAttribute("id");
						// System.out.println( nameSpace+"."+sqlId + " : " + selectList.get(i) );
						// System.out.println(nameSpace+"."+sqlId + " : " +list.get(i).evalString("/mapper/select[@id='" + sqlId+"']" ));
						// System.out.println(nameSpace+"."+sqlId + " : " +list.get(i).getNode().getTextContent());
						// System.out.println(nameSpace+"."+sqlId);
						
						sqlIdMap.put(nameSpace+"."+sqlId + "_" + nodes[ni]+"[@id='"+sqlId+"']" , list.get(i));
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}

		return sqlIdMap;
	}
	

	public void getSqlTable(Map<String, XNode> sqlIdNode) {
		
		Iterator<String> it = new TreeSet<String>(sqlIdNode.keySet()).iterator();

		String sqlIdXpath = null;	
		String [] sqlIdXpathes = null;	
		String sqlId = null;
		String xpath = null;
		XNode node = null;

		while( it.hasNext() ) {
			sqlIdXpath = it.next();
			sqlIdXpathes = sqlIdXpath.split("_");
			sqlId = sqlIdXpathes[0];
			xpath = sqlIdXpathes[1];
			
			// System.out.println(sqlId   + " : " + xpath);
			
			node = sqlIdNode.get(sqlIdXpath);
			
			String sql = node.evalString(xpath).toUpperCase();
			System.out.print(sqlId  + " : " );
			if( sql.indexOf("INSERT") >=0 ) {
				System.out.println("INSERT ");
				
				getInsertClauseTable(sql);
			} else if( sql.indexOf("UPDATE ") >=0 ) {
				System.out.println("UPDATE");
				getUpdateClauseTable(sql);
			} else if( sql.indexOf("DELETE ") >=0 ) {
				System.out.println("DELETE");
				getDeleteClauseTable(sql);
			} else if( sql.indexOf("MERGE ") >=0 ) {
				System.out.println("MERGE");
				
				getMergeClauseTable(sql);
			} else if( sql.indexOf("CALL") >=0 ) {
				System.out.println("PROCUDURE");
				
				// TODO
			} else if( sql.indexOf("EXEUTE") >=0 ) {
				System.out.println("PROCUDURE");
				
				// TODO
			} 
			// SELECT구문이 있는 경우.
			if( sql.indexOf("SELECT ") >=0 ) {
				System.out.println("SELECT");
				
				getSelectClauseTable(sql);
			}
			// System.out.println(sqlId + " : " +node.evalString(xpath));
			// System.out.println(sqlId + " : " +node.getChildren());
			// System.out.println(sqlId + " : " +node);
		}
	}
	
	/**
	 * INSERT 문에서 TABLE명 정보를 조회
	 * @param sql
	 * @return
	 */
	public Set<String> getInsertClauseTable(String sql) {
		Set<String>    set = new TreeSet<String>();

		String [] into_s = sql.split("INTO");

		String table = null;
		
		if(into_s.length > 0) {
			table = into_s[1].trim().replaceAll("(\\.|\\(|\\s).*", "");
			System.out.println(table);
			if( !"".equals(table) ) {
				set.add(table);
			}
		}
		return set;
	}

	
	/**
	 * UPDATE 문에서 TABLE명 정보를 조회
	 * @param sql
	 * @return
	 */
	public Set<String> getUpdateClauseTable(String sql) {
		Set<String>    set = new TreeSet<String>();

		String [] into_s = sql.split("UPDATE");

		String table = null;
		
		if(into_s.length > 0) {
			table = into_s[1].trim().replaceAll("(\\.|\\(|\\s).*", "");
			System.out.println(table);
			if( !"".equals(table) ) {
				set.add(table);
			}
		}
		return set;
	}

	/**
	 * DELETE 문에서 TABLE명 정보를 조회
	 * @param sql
	 * @return
	 */
	public Set<String> getDeleteClauseTable(String sql) {
		Set<String>    set = new TreeSet<String>();

		String [] into_s = sql.split("DELETE");

		String table = null;
		
		if(into_s.length > 0) {
			table = into_s[1].trim().replaceAll("FROM\\s*", "").replaceAll("(\\.|\\(|\\s).*", "");
			System.out.println(table);
			if( !"".equals(table) ) {
				set.add(table);
			}
		}
		return set;
	}
	
	/**
	 * MERGE 문에서 TABLE명 정보를 조회
	 * @param sql
	 * @return
	 */
	public Set<String> getMergeClauseTable(String sql) {
		Set<String>    set = new TreeSet<String>();

		String [] into_s = sql.split("INTO");

		String table = null;
		
		if(into_s.length > 0) {
			table = into_s[1].trim().replaceAll("(\\.|\\(|\\s).*", "");
			System.out.println(table);
			if( !"".equals(table) ) {
				set.add(table);
			}
		}
		return set;
	}
	
	/**
	 * SELECT 문에서 TABLE명 정보를 조회.
	 * @param sql
	 * @return
	 */
	public Set<String> getSelectClauseTable(String sql) {

		String [] from_s = sql.split("FROM");
		String from = null;
		String [] infrom_s = null;
		String table = null;
		Set<String>    set = new TreeSet<String>();
		for( int i=0; i<from_s.length; i++ ) {
			// System.out.println(i +  ": " + from_s[i]);
			from = from_s[i].replaceAll("(INSERT|UPDATE|DELETE|SELECT|WHERE|GROUP|ORDER|JDBCTYPE)(\\s|\\,|.)*", "");
			infrom_s = from.split("\\,");
			//System.out.println(i + ":" +from);
			
			for( int j=0; j<infrom_s.length; j++) {
				table = infrom_s[j].trim().replaceAll("(\\s|\\().*", "");
				//System.out.println(i + ":" +table);
				if( !"".equals(table) ) {
					set.add(table);
				}
			}
			
		}
		System.out.println(set);

		return set;
	}
	
	
	public static void main(String[] args) {
		HoSqlRepoter sqlReporter = new HoSqlRepoter();
		
		
		Map<String, XNode> sqlIdNode = sqlReporter.getSqlIdNode(sqlReporter.getMapperResources());
		
		sqlReporter.getSqlTable(sqlIdNode);
		
		/**
		 * 
		 */
		StackTraceElement[] stacktrace = Thread.currentThread().getStackTrace();
		
		if( stacktrace.length >= 1) {
	        StackTraceElement e = stacktrace[1];
	        String methodName = e.getMethodName();
			System.out.println( "?>>> :" +methodName);
		}

	}

}
