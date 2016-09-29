GridColumnRenderer = function() {

}

/**
 * 소수 조회..
 */
GridColumnRenderer.decFormat = function(v, precision) {
	if( Ext.isNumeric( v ) ) {
		var p = "".rpad('0', precision||2 );
		
		return Ext.util.Format.number(v, '0,0.'+p);		
	} else {
		return '0';
	}
}

/**
 * 소수 조회..
 */
GridColumnRenderer.signDecFormat = function(v, precision) {
	var val = GridColumnRenderer.decFormat(v, precision);
	
	if( val.charAt(0) == '0' || val.charAt(0) == '-' ) {
		return val;
	} else {
		return '+'+val;
	}
}

/**
 * 정수 조회..
 */
GridColumnRenderer.intFormat = function(v) {
	if( Ext.isNumeric( v ) ) {
		return Ext.util.Format.number(v, '0,0');
	} else {
		return '0';
	}
}

GridColumnRenderer.signIntFormat = function(v) {
	var val = GridColumnRenderer.intFormat(v);
	
	if( val == '0' || val.charAt(0) == '-' ) {
		return val;
	} else {
		return '+'+val;
	}
}

/**
 * 부호없는 소수점..
 */
GridColumnRenderer.decRendererFormat = function() {
	return "<div style='text-align:right;'>{1}</div>"
}

GridColumnRenderer.decRenderer = function(value, p, rec) {
	return String.format(GridColumnRenderer.decRendererFormat(), value, GridColumnRenderer.decFormat(value));
}


/**
 * 부호있는 소수점..
 */
GridColumnRenderer.signDecimalRenderer = function(value, p, rec) {
	
}

/**
 * 부호대신 색깔 있는 소수점..
 */
GridColumnRenderer.colorDecimalRenderer = function(value, p, rec) {
	
}

/**
 * 부호없는 통화(금액)점..
 */
GridColumnRenderer.moneyRenderer = function(value, p, rec) {
	
}

/**
 * 부호있는 통화(금액)점..
 */
GridColumnRenderer.signMoneyRenderer = function(value, p, rec) {
	
}

/**
 * 부호대신 색깔 통화(금액)점..
 */
GridColumnRenderer.colorMoneyRenderer = function(value, p, rec) {
	
}

/**
 * 부호없는 정수..
 */
GridColumnRenderer.intRenderer = function(value, p, rec) {
	
}

/**
 * 부호있는 정수..
 */
GridColumnRenderer.signIntRenderer = function(value, p, rec) {
	
}
/**
 * 부호대신 색깔 정수..
 */
GridColumnRenderer.colorIntRenderer = function(value, p, rec) {
	
}

/**
 * 좌파정렬
 */
GridColumnRenderer.alignLeftRenderer = function(value, p, rec) {
	
}

/**
 * 중도정렬
 */
GridColumnRenderer.alignCenterRenderer = function(value, p, rec) {
	
}

/**
 * 우파정렬
 */
GridColumnRenderer.alignRightRenderer = function(value, p, rec) {
	
}

/**
 * 날짜
 */
GridColumnRenderer.dateRenderer = function(value, p, rec) {
	
}
