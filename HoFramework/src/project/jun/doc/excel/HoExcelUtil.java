package project.jun.doc.excel;

public class HoExcelUtil {

	static HoExcelUtil heu = null;

	private HoExcelUtil() {

	}

	public static HoExcelUtil getInstance() {
		if(heu == null) {
			heu = new HoExcelUtil();
		}

		return heu;
	}

    public int getCellNum(String cellName) {
    	int cellNum = 0;
    	for( int k=0 ; k<cellName.length() ; k++) {
    		cellNum += ((k*25)+ ( k==0 ? 0 : 1 ) + ((int) cellName.charAt(k)) - 65);
    	}
    	return cellNum;
    }

    public String getCellName(int cellNum) {
    	String cellName = "";

    	if( cellNum > 701 ) {
			cellName = String.valueOf((char)(64+(cellNum/(26*27)))) + String.valueOf((char)(65+((cellNum-(26*27))/26))) + String.valueOf((char)(65+(cellNum%26)));
		} else if( cellNum > 25 ) {
			cellName = String.valueOf((char)(64+(cellNum/26))) + String.valueOf((char)(65+(cellNum%26)));
		} else {
			cellName = String.valueOf((char)(65+cellNum));
		}

    	return cellName;
    }

}
