package project.jun.doc.excel.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import project.jun.doc.excel.HoExcelReader;
import project.jun.util.HoFormatter;

public class HoExcelXSSFReader implements HoExcelReader {

	XSSFWorkbook workbook = null;
	XSSFSheet    sheet    = null;

	public void setExelFile(InputStream is) throws FileNotFoundException, IOException {
		workbook = new XSSFWorkbook( is );

    	sheet = workbook.getSheetAt(0);
	}

	public void setExelFile(String fileName) throws FileNotFoundException, IOException {
    	workbook = new XSSFWorkbook( new FileInputStream( new File( fileName)));
    	sheet = workbook.getSheetAt(0);
	}

	public void setExelFile(File file) throws FileNotFoundException, IOException {
    	workbook = new XSSFWorkbook( new FileInputStream( file ));
    	sheet = workbook.getSheetAt(0);
	}

	public void setSheet(int sheetIdx) throws FileNotFoundException, IOException {
    	sheet = workbook.getSheetAt(sheetIdx);

	}

	public Object getRow(int row) throws FileNotFoundException, IOException {
    	return sheet.getRow(row);
	}

    /*
     * added for POI
     */
    public XSSFRow getXSSFRow(int row) throws FileNotFoundException, IOException {
    	return sheet.getRow(row);
    }


	public Object getCell(int row, int cell) throws FileNotFoundException, IOException {
    	return getXSSFRow(row).getCell(cell);
	}

    /*
     * added for POI
     */
    public XSSFCell getXSSFCell(int row, int cell) throws FileNotFoundException, IOException {
    	return getXSSFRow(row).getCell(cell);
    }

	public int getLastRowNum() {
		return sheet.getLastRowNum();
	}

	public int getLastRowNum(int sheetIdx) throws FileNotFoundException, IOException {
    	return workbook.getSheetAt(sheetIdx).getLastRowNum();
	}

	public int getLastCellNum(int row) throws FileNotFoundException, IOException {
    	return getXSSFRow(row).getLastCellNum();
	}

	public int getLastCellNum(int sheetIdx, int row) throws FileNotFoundException, IOException {
    	return workbook.getSheetAt(sheetIdx).getRow(row).getLastCellNum();
	}

	public Object getValueRichTextString(int row, int cell) throws FileNotFoundException, IOException {
    	return getCell(row, cell) == null ? new XSSFRichTextString() : getXSSFCell(row, cell).getRichStringCellValue();
	}

    public String getStringValue (int row, int cell  ) throws FileNotFoundException, IOException {
    	return getCell(row, cell) == null ? "" : getXSSFCell(row, cell).getRichStringCellValue().getString();
    }

    public double getDoubleValue (int row, int cell  ) throws FileNotFoundException, IOException {
    	return getCell(row, cell) == null ? 0 : getXSSFCell(row, cell).getNumericCellValue();
    }

    public Date getDateValue (int row, int cell  ) throws FileNotFoundException, IOException {
    	return getCell(row, cell) == null ? new Date() : getXSSFCell(row, cell).getDateCellValue();
    }


	public Object getValue(int row, int cell) throws FileNotFoundException, IOException {
	   	Object obj = null;
    	try {
    		if( getXSSFCell(row, cell).getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
	    		obj = HoFormatter.toNumberRawFormat(new Double(getDoubleValue(row, cell)));

	        }
	    	else {
	    		obj = getStringValue(row, cell);
	        }
    	} catch(NullPointerException e)
    	{
    		obj = new String();
    	}
    	return obj;
    }


	public Object getCell(int row, String cell) throws FileNotFoundException, IOException {
    	return getXSSFRow(row).getCell(heu.getCellNum(cell));
	}

	public Object getValueRichTextString(int row, String cell) throws FileNotFoundException, IOException {
		return getValueRichTextString(row, heu.getCellNum(cell));
	}

	public String getStringValue(int row, String cell) throws FileNotFoundException, IOException {
		return getStringValue(row, heu.getCellNum(cell));
	}

	public double getDoubleValue(int row, String cell) throws FileNotFoundException, IOException {
		return getDoubleValue(row, heu.getCellNum(cell));
	}

	public Date getDateValue(int row, String cell) throws FileNotFoundException, IOException {
		return getDateValue(row, heu.getCellNum(cell));
	}

	public Object getValue(int row, String cell) throws FileNotFoundException, IOException {
		return getValue(row, heu.getCellNum(cell));
	}



}
