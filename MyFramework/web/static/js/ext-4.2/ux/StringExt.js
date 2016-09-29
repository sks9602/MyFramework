
/*
 * String에 endsWith() 추가
 */
if (typeof String.prototype.endsWith !== 'function') {
    String.prototype.endsWith = function(s) {
        return (this.match(s+"$")==s); // this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
}
 
/*
 * String에 startsWith() 추가
 */
if (typeof String.prototype.startsWith !== 'function') {
    String.prototype.startsWith = function(s) {
        return (this.match("^"+s)==s); 
    };
}

/**
 * max보다 큰 String의 String 자르기 기능 추가
 */
if (typeof String.prototype.cut !== 'function') {
	String.prototype.cut = function(max) {
		var str = this;
		var pos = 0;
	
		for( var i=0;i<str.length ;i++) {
			pos+=(str.charCodeAt(i)>127) ? 3 : 1; // utf-8 : 3, etc : 2
			if( pos>max) {
				return str.substring(0,i);
			}
		}
		return str;
	}
}
/**
 * lpad
 */
String.prototype.lpad = function(c, n) {
	var s = this;
	if (! s || ! c || s.length >= n) {
        return s;
    }
 
    var max = (n - s.length)/c.length;
    for (var i = 0; i < max; i++) {
        s = c + s;
    }
 
    return s;
}


/**
 * rpad
 */
String.prototype.rpad = function(c, n) {
	var s = this;
	if (! s || ! c || s.length >= n) {
        return s;
    }
 
    var max = (n - s.length)/c.length;
    for (var i = 0; i < max; i++) {
        s += c;
    }
 
    return s;
}

/*
 * trim
 */
String.prototype.trim = function() {
	var str = this.replace(/(\s+$)/g,"");
		
	return  str.replace(/(^\s*)/g,"");
}

