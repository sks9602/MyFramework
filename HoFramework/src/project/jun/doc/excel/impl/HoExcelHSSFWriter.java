package project.jun.doc.excel.impl;import java.io.File;import java.io.FileInputStream;import java.io.FileNotFoundException;import java.io.IOException;import org.apache.poi.hssf.usermodel.HSSFCell;import org.apache.poi.hssf.usermodel.HSSFCellStyle;import org.apache.poi.hssf.usermodel.HSSFFont;import org.apache.poi.hssf.usermodel.HSSFRichTextString;import org.apache.poi.hssf.usermodel.HSSFRow;import org.apache.poi.hssf.usermodel.HSSFSheet;import org.apache.poi.hssf.usermodel.HSSFWorkbook;import org.apache.poi.hssf.util.Region;import project.jun.doc.excel.HoExcelWriter;public class HoExcelHSSFWriter implements HoExcelWriter {	HSSFWorkbook workbook = null;    HSSFSheet    sheet    = null;    public void setWorkbook(Object wb) throws Exception {    	if( wb instanceof HSSFWorkbook) {    		this.workbook = (HSSFWorkbook) wb;    	} else {    		throw new ClassCastException("Workbook must be instance of HSSFWorkbook!!");    	}    }    public void createExel(String file) throws FileNotFoundException, IOException {    	workbook = new HSSFWorkbook(new FileInputStream( new File( file)));    }    public void createExel() throws FileNotFoundException, IOException {    	workbook = new HSSFWorkbook();    }    public Object getWorkBook() {    	return this.workbook;    }    /**     * add for POI     * @return     */    public HSSFWorkbook getHSSFWorkBook() {    	return this.workbook;    }    public void createSheet(String sheetName) throws FileNotFoundException, IOException {    	sheet = workbook.createSheet(sheetName);    }    public void createSheet() throws FileNotFoundException, IOException {    	sheet = workbook.createSheet();    }    public Object createRow(int row) throws FileNotFoundException, IOException {    	if( workbook == null ) {    		workbook = new HSSFWorkbook();    	}    	if( sheet == null ) {    		createSheet();    	}    	return sheet.getRow(row)!=null ? sheet.getRow(row) : sheet.createRow(row);    }    /**     * add for POI     * @return     */    public HSSFRow createHSSFRow(int row) throws FileNotFoundException, IOException {    	if( workbook == null ) {    		workbook = new HSSFWorkbook();    	}    	if( sheet == null ) {    		createSheet();    	}    	return sheet.getRow(row)!=null ? sheet.getRow(row) : sheet.createRow(row);    }    public Object createCell(int row, int cell) throws FileNotFoundException, IOException {    	return createHSSFRow(row).getCell(cell)==null ? createHSSFRow(row).createCell(cell) : sheet.getRow(row).createCell(cell);    }    /**     * add for POI     * @return     */    public HSSFCell createHSSFCell(int row, int cell) throws FileNotFoundException, IOException {    	return createHSSFRow(row).getCell(cell)==null ? createHSSFRow(row).createCell(cell) : sheet.getRow(row).createCell(cell);    }    public void setCellValue(int row, int cell, String value) throws FileNotFoundException, IOException {    	HSSFRichTextString strValue = new HSSFRichTextString(value);    	createHSSFCell(row, cell).setCellValue(strValue);    }    public void setCellValue(int row, int cell, long value) throws FileNotFoundException, IOException {    	createHSSFCell(row, cell).setCellValue(value);    }    public void setCellValue(int row, int cell, double value) throws FileNotFoundException, IOException {    	createHSSFCell(row, cell).setCellValue(value);    }    public void setCellStyleToTitle(int row, int cell) throws FileNotFoundException, IOException {    	if( sheet.getRow(row).getCell(cell) == null ) {    		createHSSFCell(row, cell).setCellStyle(createTitleCellStyle());    	} else {    		sheet.getRow(row).getCell(cell).setCellStyle(createTitleCellStyle());    	}    }    public void setCellStyleToData(int row, int cell) throws FileNotFoundException, IOException {    	if( sheet.getRow(row).getCell(cell) == null ) {    		createHSSFCell(row, cell).setCellStyle(createDataCellStyle());    	} else {    		sheet.getRow(row).getCell(cell).setCellStyle(createDataCellStyle());    	}    }    public void setCellStyle(int row, int cell, Object style) throws FileNotFoundException, IOException {    	if( sheet.getRow(row).getCell(cell) == null ) {    		createHSSFCell(row, cell).setCellStyle((HSSFCellStyle)style);    	} else {    		sheet.getRow(row).getCell(cell).setCellStyle((HSSFCellStyle) style);    	}    }    public void setWidth(String cell, int width) {    	if(sheet !=null ) {    		sheet.setColumnWidth(heu.getCellNum(cell), width);    	}    }    public int getWidth(String cell) {    	return sheet.getColumnWidth(heu.getCellNum(cell));    }    public void setHeight(int row, short height) {    	if( sheet.getRow(row)!=null ) {    		sheet.getRow(row).setHeight(height);    	}    }    public void span(int rowFrom, short colFrom, int rowSpanLength, short colSpanLength) {    	sheet.addMergedRegion(new Region(rowFrom, colFrom, rowFrom+rowSpanLength, (short)(colFrom+colSpanLength)));    }    public void addMergedRegion(int rowFrom, short colFrom, int rowTo, short colTo) {    	sheet.addMergedRegion(new Region(rowFrom, colFrom, rowTo, colTo));    }    public void addMergedRegion(int rowFrom, int colFrom, int rowTo, int colTo) {    	sheet.addMergedRegion(new Region(rowFrom, (short)colFrom, rowTo, (short)colTo));    }	public HSSFCellStyle createTitleCellStyle() {		HSSFCellStyle cell_style = workbook.createCellStyle();		HSSFFont font = workbook.createFont();		// Border, Foreground Color Setting		cell_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);		cell_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);		cell_style.setBorderRight(HSSFCellStyle.BORDER_THIN);		cell_style.setBorderTop(HSSFCellStyle.BORDER_THIN);		cell_style.setFillPattern((short)1);		cell_style.setFillForegroundColor((short)23);		// Font Setting		font.setFontHeightInPoints((short)10);		font.setColor((short)9);		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		cell_style.setFont(font);		return cell_style;	}	public HSSFCellStyle createDataCellStyle() {		HSSFCellStyle cell_style = workbook.createCellStyle();		HSSFFont font = workbook.createFont();		// Border, Foreground Color Setting		cell_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);		cell_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);		cell_style.setBorderRight(HSSFCellStyle.BORDER_THIN);		cell_style.setBorderTop(HSSFCellStyle.BORDER_THIN);		// Font Setting		font.setFontHeightInPoints((short)9);		cell_style.setFont(font);		return cell_style;	}	public Object createCell(int row, String cell) throws FileNotFoundException, IOException {		return this.createCell(row, heu.getCellNum(cell));	}	public void setCellValue(int row, String cell, String value) throws FileNotFoundException, IOException {		this.setCellValue(row, heu.getCellNum(cell), value);	}	public void setCellValue(int row, String cell, long value) throws FileNotFoundException, IOException {		this.setCellValue(row, heu.getCellNum(cell), value);	}	public void setCellValue(int row, String cell, double value) throws FileNotFoundException, IOException {		this.setCellValue(row, heu.getCellNum(cell), value);	}	public void setCellStyleToTitle(int row, String cell) throws FileNotFoundException, IOException {		this.setCellStyleToTitle(row, heu.getCellNum(cell));	}	public void setCellStyleToData(int row, String cell) throws FileNotFoundException, IOException {		this.setCellStyleToData(row, heu.getCellNum(cell));	}	public void setCellStyle(int row, String cell, Object style) throws FileNotFoundException, IOException {		this.setCellStyle(row, heu.getCellNum(cell), style);	}}