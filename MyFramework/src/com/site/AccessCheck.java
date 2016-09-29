package com.site;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

import project.jun.util.HoExcelReader;
import project.jun.util.HoExcelWriter;
import project.jun.util.HoHttpClient;

public class AccessCheck extends QuartzJobBean {

	List serverList = new ArrayList();
	String excelFileName = null;


	public void setServerList(List serverList) {
		this.serverList = serverList;
	}


	public List getServerList() {
		return this.serverList;
	}

	public void setExcelFileName(String excelFileName) {
		this.excelFileName = excelFileName;
	}

	public String getExcelFileName() {
		return this.excelFileName;
	}


	public boolean ping(String server) {
		boolean isALive = false;
		try {
			InetAddress address = InetAddress.getByName(server);

			isALive = address.isReachable(3000);
		} catch(Exception e) {

		}
		return isALive;
	}



	/**
	 * 서버가 살아있는지 확인
	 * @param server
	 * @return
	 */
	public boolean isAlive(String server) {
		boolean isALive = false;
		try {
			final URLConnection connection = new URL(server).openConnection();

			connection.connect();

			isALive = true;
		} catch(Exception e) {
			isALive = false;
		}
		return isALive;
	}

    public int readDataToExcelFile(){

        try{
            FileInputStream fis = new FileInputStream(getExcelFileName());
            HSSFWorkbook workbook = new HSSFWorkbook(fis);
            HSSFSheet sheet = workbook.getSheetAt(0);

            fis.close();

            workbook = null;

            return sheet.getLastRowNum()+1;

        }catch(Exception e){
            e.printStackTrace();
            return -1;
        }
    }


	private HSSFCellStyle createTitleCellStyle(HSSFWorkbook workbook) {

		HSSFCellStyle cell_style = workbook.createCellStyle();
		HSSFFont font = workbook.createFont();
		// Border, Foreground Color Setting
		cell_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cell_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cell_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cell_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell_style.setFillPattern((short)1);
		cell_style.setFillForegroundColor((short)23);
		cell_style.setAlignment(CellStyle.ALIGN_CENTER);
		// Font Setting
		font.setFontHeightInPoints((short)10);
		font.setColor((short)9);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

		cell_style.setFont(font);

		return cell_style;
	}


	private HSSFCellStyle createDataCellStyle(HSSFWorkbook workbook, int align) {
		HSSFCellStyle cell_style = workbook.createCellStyle();
		HSSFFont font = workbook.createFont();

		// Border, Foreground Color Setting
		cell_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cell_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cell_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cell_style.setBorderTop(HSSFCellStyle.BORDER_THIN);

		if( align ==  0 ) {
			cell_style.setAlignment(CellStyle.ALIGN_LEFT);
		} else if( align ==  4 || align ==  7) {
			cell_style.setAlignment(CellStyle.ALIGN_RIGHT);
		} else {
			cell_style.setAlignment(CellStyle.ALIGN_CENTER);
		}
		// Font Setting
		font.setFontHeightInPoints((short)9);

		cell_style.setFont(font);

		return cell_style;
	}
    public int writeDataToExcelFile(int rowNum, String [] values) {
        try {

            HSSFWorkbook workBook = new HSSFWorkbook();

            if( rowNum <= 0 ) {
            	workBook = new HSSFWorkbook();
        	} else {
                FileInputStream fis = new FileInputStream(getExcelFileName());
        		workBook = new HSSFWorkbook(fis);
        	}

            HSSFSheet    sheet = workBook.getSheet("SiteCheck");

            if( sheet == null  ) {
            	sheet = workBook.createSheet("SiteCheck");
            }
            HSSFRow      row;
            HSSFCell     cell;


            String [] titles = {"서버주소","서버상태","응답코드","응답","응답 길이","호출 시간","응답 시간","소요 시간"};

        	sheet.setColumnWidth(0, 6000);
        	sheet.setColumnWidth(1, 3000);
        	sheet.setColumnWidth(2, 3000);
        	sheet.setColumnWidth(3, 2000);
        	sheet.setColumnWidth(4, 3500);
        	sheet.setColumnWidth(5, 5500);
        	sheet.setColumnWidth(6, 5500);
        	sheet.setColumnWidth(7, 3500);

            if( rowNum <= 0 ) {
            	row = sheet.createRow(0);
            	for( int cellNum=0; cellNum<titles.length; cellNum++) {
                	cell = row.createCell(cellNum);
                	cell.setCellValue(new HSSFRichTextString(titles[cellNum]));
                	cell.setCellStyle(createTitleCellStyle(workBook));

            	}
            	rowNum = 1;
            }

        	row = sheet.createRow(rowNum);
			System.out.println(" rowNum : " + rowNum );
        	for( int cellNum=0; cellNum<titles.length; cellNum++) {
            	cell = row.createCell(cellNum);
            	cell.setCellValue(new HSSFRichTextString(values[cellNum]));
            	cell.setCellStyle(createDataCellStyle(workBook, cellNum));
        		//sheet.autoSizeColumn(cellNum);
        	}

            FileOutputStream out = new FileOutputStream(getExcelFileName());
            workBook.write(out);
            out.flush();
            out.close();

            workBook = null;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowNum++;
    }



	@Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
        SimpleDateFormat sheetSdf = new SimpleDateFormat("yyyy.MM");

        setExcelFileName(((String) context.getJobDetail().getJobDataMap().get("excelFileName")).replaceAll("#YYYY.MM#", sheetSdf.format(System.currentTimeMillis())));
        setServerList((List) context.getJobDetail().getJobDataMap().get("serverList"));
        /*
		setExcelFileName("d:/TEMP/SiteCheck_"+sheetSdf.format(System.currentTimeMillis())+".xls");

        serverList.add("http://www.daum.net");
		serverList.add("http://www.naver.com");
		serverList.add("https://www.kdn.com");
		*/
		String server;

		HoHttpClient http = new HoHttpClient("euc-kr");


		int    statucCode = 0;
		String statucText = null;
		int    length     = 0;

		int pos = 0;
		int lastRow = readDataToExcelFile();

		for( Object serverName : serverList.toArray() ) {
			server = (String) serverName;

			statucCode = 0;
			statucText = null;
			length     = 0;

	        long startTime = System.currentTimeMillis();
	        long endTime   = 0L;

			boolean isAlive = isAlive(server);

			try {
				http.post(server);
				statucCode = http.getStatusCode();
				statucText = http.getStatusText();
				length     = http.getResponse().length();

				if( statucCode == 0 ) {
					statucText = "ERROR";
					length     = 0;
				}
			} catch (UnsupportedEncodingException e) {
				statucCode = -1;
				statucText = "ERROR";
				length     = 0;
			}
			endTime = System.currentTimeMillis();

			long estimagedTime = endTime - startTime;



			String [] values = {server , isAlive ? "ALIVE" : "DEAD", String.valueOf(statucCode), statucText, String.valueOf(length), sdf.format(startTime), sdf.format(endTime), String.valueOf(estimagedTime) };

			System.out.println(" lastRow : " + lastRow );

			writeDataToExcelFile( lastRow, values);

			if(lastRow <= 0 ) {
				lastRow = 1;
			}
			lastRow++;

	        System.out.println(server + "  : " + isAlive + "  : " + statucCode + "  : " + statucText + "  : " + length + "  : "  + sdf.format(startTime) + " / " + sdf.format(endTime) + " -> " + estimagedTime );

		}
    }

	public static void main(String [] args) {

		String applicationContexts[] = {
				"project/config/applicationContext-quartz.xml"

		};

		ApplicationContext context = new ClassPathXmlApplicationContext(applicationContexts);

	}
}
