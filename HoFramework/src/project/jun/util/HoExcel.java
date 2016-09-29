package project.jun.util;

public class HoExcel {

    public int getCellNum(String cell) {
    	int cellIdx = 0;
    	int idxVal = 0;

    	String cellUp = cell.toUpperCase();


    	for( int i=cellUp.length()-1,j=0  ;i>=0; i--, j++ ) {

    		idxVal = (int)cellUp.charAt(i) - 65;

    		cellIdx += (idxVal +1) * Math.pow(26, j);
    	}

    	cellIdx--;

    	return cellIdx;
    }

    public String getCellName(int cellNum) {
    	String cellName = "";

        while( true ) {
        	cellName = (char)(65+cellNum%26) + cellName;
        	cellNum --;
        	if( cellNum <= 0) {
        		break;
        	}
        	cellNum /= 26;
        }
    	return cellName;
    }

}
