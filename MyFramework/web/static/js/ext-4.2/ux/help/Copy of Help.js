/*
 * ProcessMap을 조회 하기 위한 Window
 * mouseover시 rect의 중간 지점에 점 표시 까지 
 */
Ext.define('Ext.window.ux.Help', {
	extend: 'Ext.window.Window',
    title: 'Help',
    id : 'id_main_top_win_help',
    menuId : undefined ,
    height: 800,
    // baseCls : 'x-window-red',
    width: 1200,
    x : 100,
    y : 100,
    layout: 'border',
    constrain: true,
    border : false,
    closable: true,
    closeAction: 'hide',
    minimizable : true,
    maximizable: true,
    items: [{  // 
    	region : 'center',
        xtype: 'tabpanel',
        border : true,
        items : [{
            title: 'Process Map',
            layout: 'border',
            border : false,
            items : [{
            	xtype : 'panel',
            	id : 'id_main_top_win_help_panel',
            	listeners : {
            		render : function (_this, eOpts) {
            			drawProcessMap(_this.up('window').menuId);
            		}
            	}
            	
            }]
        }]
    }],
    listeners : {
    	move : function(_this, x, y, eOpts) {
    		
    	},
    	minimize: function(_this, eOpts) {
    		_this.hide('id_main_tabpanel_help');
    	}
    },
	initComponent: function() {
		this.callParent(arguments);
	}
});

function drawProcessMap(menuId) {
	var r = Raphael("id_main_top_win_help_panel", 1150, 790);
	

	var rect1 = drawRpRectPrcCmp(r, 20, 20, 'Title', 'Desc Desc Desc Desc Desc Desc Desc \nDesc Desc Desc  \nDesc Desc Desc \nDesc Desc Desc ', 'good',['강사 관리', '과목 관리']);

	var rect2 = drawRpRectPrcCmp(r, 450, 20, '과정관리', 'Desc Desc Desc Desc Desc Desc Desc \nDesc Desc Desc  \nDesc Desc Desc \nDesc Desc Desc ', 'good',['자료 관리', '시험 관리', '설문 관리']);

	drawRpLine(r, rect1, "r", rect2, "l");
}



/**
 * 프로세스맵을 위한 네모 상자를 그린다.
 * @param r : Raphael 
 * 
 * @param x
 * @param y
 * @param t : 제목
 * @param d : Description
 * @param subCmp : Array - 하위 컴포넌트
 */
function drawRpRectPrcCmp(r, x, y, t, d, status, subCmp) {
	var p = 8, // padding  
		cmp=[], 
		tw=150, th=30, // Title width, height
		w=250, h=p+th/2, // Initial Width, Height
		wg=w-tw, // Width Gap
		subCmpH = 30, subCmpW = 250-(p*2); 
	var tts = {fill:"#fff", "text-anchor" : "middle", font: '14px Helvetica, Arial', fill: "#000", "text-anchor" : "middle"}, // Title Text Style
		dts = {fill:"#fff", "text-anchor" : "middle", font: '12px Helvetica, Arial', fill: "#000", "text-anchor" : "start"}, // Description Text Style
		stts = {fill:"#fff", "text-anchor" : "middle", font: '14px Helvetica, Arial', fill: "#000", "text-anchor" : "middle"}, // Sub Component Text Style
		cts = {fill:"#f00", "text-anchor" : "middle", font: '10px Helvetica, Arial', fill: "#f00", "text-anchor" : "middle"}; 

	// Description Text
	var dt = r.text( x+p, y+th+p, d ).attr(dts);
	var dtbb = dt.getBBox();
	
	h+= dtbb.height;
	h+= p;
	
	if( subCmp && Ext.isArray(subCmp)) {
		h+= subCmp.length * (subCmpH + p)
	}
	// Description Component
	var dc = r.rect(x, y+th/2, w, h, 2).attr({"fill" : "#fff", "stroke": "#0ff"});
	dc.mouseover(function( _event ) {
		// cmp.push(dc);
		drawRpRectPoint(r, dc);
	});

	// Description Text 위치 가운데로 보정
	dt.attr("y", y+th+p+dtbb.height/2 ).toFront();
	cmp.push(dt);
	
	// Sub Component 그리기
	dtbb = dt.getBBox();
	var sc = new Array();
	var st = new Array();
	for( var i=0; i<subCmp.length ; i++) {
		sc[i] = r.rect(x+p, dtbb.y + dtbb.height + p*(i+1) + subCmpH*i, subCmpW, subCmpH).attr({"fill" : "#fff", "stroke": "#f00"}).toFront();
		cmp.push(sc[i]);

		st[i] = r.text(sc[i].attr("x")+subCmpW/2, sc[i].attr("y")+subCmpH/2, subCmp[i] ).attr(stts);
		cmp.push(st[i]);

		(function(j) {
			sc[j].mouseover(function( ) {
				drawRpRectPoint(r, sc[j] );
			});			
		})(i);

	}

	// Title Component
	var tc = r.rect(x+wg/2, y, tw, th, 5).attr({"fill" : "#fff", "stroke": "#00f"});
	cmp.push(tc);	
	// Title Text
	var tt=r.text(tc.attr("x")+tw/2,tc.attr("y")+th/2,t).attr(tts);
	cmp.push(tt);	
	
	// 컴포넌트 전체 감싸는 Rectanguler
	// var cc = r.rect(x, y, w, h+th/2).attr({"stroke-width" : 0, "stroke-opacity" : 1, "opacity": 1}).toBack();
	// cmp.push(cc);
	
	cmp.push(dc);
	return cmp;
}

/**
 * 네모 상자의 top, right, bottom, left에 circle을 그린다.
 * @param r : Raphael
 * @param rect : 네모
 */
function drawRpRectPoint(r, rect) {
	var cts = {fill:"#f00", "text-anchor" : "middle", font: '10px Helvetica, Arial', fill: "#f00", "text-anchor" : "middle"};
/*
	var cc = r.circle(rect.attr("x") + rect.attr("width")/2, rect.attr("y")+ rect.attr("height")/2, 4).attr({"fill" : "#000"}).toFront();
	r.text(rect.attr("x") + rect.attr("width")/2, rect.attr("y") - 10 + rect.attr("height")/2,  (rect.attr("x") + rect.attr("width")/2) +":"+( rect.attr("y") + rect.attr("height")/2) ).attr(cts);
*/
	var ct = r.circle(rect.attr("x") + rect.attr("width")/2, rect.attr("y"), 4).attr({"fill" : "#000"});
	(function (dot) {
		ct.hover(function() {
			dot.attr({"fill" : "#f00"});
		},function() {
			dot.attr({"fill" : "#000"});
		});
	})(ct);
	ct.toFront();
	//r.text(rect.attr("x") + rect.attr("width")/2, rect.attr("y") - 10 ,  (rect.attr("x") + rect.attr("width")/2) +":"+( rect.attr("y") ) ).attr(cts);

	var cr = r.circle(rect.attr("x") + rect.attr("width"), rect.attr("y") + rect.attr("height")/2 , 4).attr({"fill" : "#000"}).toFront();;
	//r.text(rect.attr("x") + rect.attr("width"), rect.attr("y") - 10+ rect.attr("height")/2 ,  (rect.attr("x") + rect.attr("width")) +":"+( rect.attr("y")+ rect.attr("height")/2 ) ).attr(cts);
	
	var cb = r.circle(rect.attr("x") + rect.attr("width")/2, rect.attr("y") + rect.attr("height") , 4).attr({"fill" : "#000"}).toFront();;
	//r.text(rect.attr("x") + rect.attr("width")/2, rect.attr("y") - 10+ rect.attr("height") ,  (rect.attr("x") + rect.attr("width")/2) +":"+( rect.attr("y")+ rect.attr("height") ) ).attr(cts);

	var cl = r.circle(rect.attr("x") , rect.attr("y") + rect.attr("height")/2 , 4).attr({"fill" : "#000"}).toFront();;
	//r.text(rect.attr("x"), rect.attr("y") - 10 + rect.attr("height")/2 ,  (rect.attr("x")) +":"+( rect.attr("y")+ rect.attr("height")/2 ) ).attr(cts);
	
}
/**
 * 두 프로세스맵 컴포넌트간에 연결선을 그린다.
 * @param r : Raphael
 * @param scg : 라인 시작 컴포넌트 그룹
 * @param sp : 라인 시작 위치 (t : top, r : right, b : bottom, l : left) - start Position
 * @param ecg : 라인 종료 컴포넌트 그룹
 * @param ep : 라인 종료 위치 (t : top, r : right, b : bottom, l : left) - end Position
 */
function drawRpLine(r, scg, sp, ecg, ep) {
	var sc = scg.pop(), ec=ecg.pop(); // 컴포넌트 전체 감싸는 Rectanguler 조회
	var sx=0, sy=0, ex=0, ey=0, lpath=[], epath, mx, my;
	switch (sp) {
		case "t" :  
			sx = sc.attr("x") + sc.attr("width")/2;
			sy = sc.attr("y");
			lpath.push('M'+(sx) +' '+sy+'v-10');
			break;
		case "r" :  
			sx = sc.attr("x") + sc.attr("width");
			sy = sc.attr("y") + sc.attr("height")/2;
			lpath.push('M'+sx+' '+sy);
			break;
		case "b" :  
			sx = sc.attr("x") + sc.attr("width")/2;
			sy = sc.attr("y") + sc.attr("height");
			break;
		case "l" :  
			sx = sc.attr("x");
			sy = sc.attr("y") + sc.attr("height")/2;
			break;
		default : 
			sx = 0;
			sy = 0;
			break;
	}
	// 시작점에 circle 그리기
	r.circle(sx, sy, 4).attr({"fill" : "#000"});
	
	switch (ep) {
		case "t" :  
			ex = ec.attr("x") + ec.attr("width")/2;
			ey = ec.attr("y");
			//epath = 'M'+ex +' '+ey+'l5-5l-10,0z';
			break;
		case "r" :  
			ex = ec.attr("x") + ec.attr("width");
			ey = ec.attr("y") + ec.attr("height")/2;
			break;
		case "b" :  
			ex = ec.attr("x") + ec.attr("width")/2;
			ey = ec.attr("y") + ec.attr("height");
			break;
		case "l" :  
			ex = ec.attr("x");
			ey = ec.attr("y") + ec.attr("height")/2;
			epath = 'M'+ex+' '+ey+'l-5,5l5,-5l-5-5v10z';
			break;
		default : 
			ex = 0;
			ey = 0;
			break;
	}

	r.path(epath).attr({"fill" : "#000", "stroke-width" : 4});;

	mx = (ex-sx)/2;
	my = (ey-sy);

	r.path('M'+sx+' '+sy+'h'+mx).attr({"fill" : "#000", "stroke-width" : 4});;
	r.path('M'+(sx+mx)+' '+(sy-2)+'v'+(my+4)).attr({"fill" : "#000", "stroke-width" : 4});;
	r.path('M'+(sx+mx)+' '+(sy+my)+'h'+mx).attr({"fill" : "#000", "stroke-width" : 4});;

	
	// 종료점에 삼각형 그리기
	r.path(lpath.join('')).attr({"fill" : "#000", "stroke-width" : 4});;

}