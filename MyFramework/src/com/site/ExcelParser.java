package com.site;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelParser {

	public String getExcelFileName() {
		return "s:/1.PROJECT/2013_다인/2014_02_경북대/경북대학교 핵심역량진단 설문서 코딩-1반.xlsx";
	}


	public static void main(String [] args) {

		XSSFWorkbook workBook = null;

		ExcelParser ep = new ExcelParser();

		FileInputStream fis;

		Connection conn = null;
		PreparedStatement pstmtMember = null;
		PreparedStatement pstmtDia = null;

		try {
			fis = new FileInputStream(ep.getExcelFileName());
			workBook = new XSSFWorkbook(fis);


			XSSFSheet    sheet = workBook.getSheetAt(0);

			XSSFRow      row = null;
			XSSFCell     cell = null;


			String DB_URL = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
			String DB_USER = "scott";
			String DB_PASSWORD = "tiger";


			String queryMember = "INSERT INTO HR_MEMBER(컬럼들) VALUES ( ?, ? 컬럼개수 만큼) ";
			String queryDia = "INSERT INTO HR_진단(컬럼들) VALUES ( ?, ? 컬럼개수 만큼) ";

			try {
				// 드라이버를 로딩한다.
				Class.forName("oracle.jdbc.driver.OracleDriver");
			} catch (ClassNotFoundException e ) {
				e.printStackTrace();
			}

			// 데이터베이스의 연결을 설정한다.
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

			// Statement를 가져온다.
			pstmtMember = conn.prepareStatement(queryMember);
			pstmtDia = conn.prepareStatement(queryDia);

			String uniqueId = "";
			double no = 0;
			double cls = 0;
			String fm = "";
			String name = "";
			double year = 0;
			double grd =0;
			String dept = "";
			String deptGrp = "";
			String major = "";
			String jobGrp = "";
        	String job = null;

            for( int colIndex=1; colIndex<=32; colIndex++) {
            	no = ep.getValueNum(sheet,1, colIndex);
            	cls = ep.getValueNum(sheet,2, colIndex);
            	fm = ep.getValue(sheet,3, colIndex);
            	name = ep.getValue(sheet,4, colIndex);
            	year = ep.getValueNum(sheet,5, colIndex);
            	grd =  ep.getValueNum(sheet,6, colIndex);
            	dept = ep.getValue(sheet,7, colIndex);
            	deptGrp =  ep.getValue(sheet,8, colIndex);
            	major = ep.getValue(sheet,9, colIndex);

            	// 가짜 학번..
            	uniqueId = (year == 0l ? "14" : year+"" ) + (cls < 10l ? "0"+cls : cls ) + (no < 10l ? "0"+no : no );

            	for( int i=10; i<=15; i++) {
            		job = ep.getValue(sheet,i, colIndex);
            		// 관심직업군 하드코딩 필요
            		if( !job.equals("") ) {
            			if( i==10) {
            				jobGrp = "관리자";
            			}else if( i==11) {
            				jobGrp = "전문가 및 관련 종사자";
            			}else if( i==12) {
            				jobGrp = "사무종사자";
            			}else if( i==13) {
            				jobGrp = "서비스 및판매종사자";
            			}else if( i==14) {
            				jobGrp = "농림어업 숙련 종사자";
            			}else if( i==15) {
            				jobGrp = "기능, 장치 및 기계 종사자";
            			}
            			break;
            		}

            	}

            	pstmtMember.setString(1, uniqueId);// ?물음표위치에 맞게..

            	pstmtMember.addBatch();

            	for( int rowIndex=16 ;rowIndex<101; rowIndex++) {
	            	cell = row.getCell(colIndex);

	            	if( cell != null ) {
		            	if( cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
		            		System.out.print( cell.getNumericCellValue());
		            	} else {
		            		System.out.print( cell.getStringCellValue());
		            	}
	            	} else {
	            		System.out.print( "null");
	            	}
            		System.out.print( " ");
                	pstmtDia.setString(1, ""); //물음표 개수에 맞게..

                	pstmtDia.addBatch();
	            }

            	pstmtDia.executeBatch();

            }
            pstmtMember.executeBatch();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try{ pstmtDia.close();} catch(Exception e){} finally{pstmtDia=null;}
			try{ pstmtMember.close();} catch(Exception e){} finally{pstmtMember=null;}
			try{ conn.close();} catch(Exception e){} finally{conn=null;}
		}
	}

	public double getValueNum(XSSFSheet    sheet, int rowIndex, int cellIdx) {
		XSSFRow      row = sheet.getRow(2);

		XSSFCell cell = row.getCell(cellIdx);
		if( cell != null ) {
			return cell.getNumericCellValue();
		} else {
			return 0l;
		}
	}

	public String getValue(XSSFSheet    sheet, int rowIndex, int cellIdx) {
		XSSFRow      row = sheet.getRow(2);

		XSSFCell cell = row.getCell(cellIdx);
		if( cell != null ) {
			return cell.getStringCellValue();
		} else {
			return "";
		}
	}
}
