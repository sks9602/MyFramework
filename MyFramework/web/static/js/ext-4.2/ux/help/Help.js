/*
 * ProcessMap을 조회 하기 위한 Window
 */

(function(Raphael) {
	Raphael.drawer = function(menuId) {
		return new Drawer(menuId);
	}
	
	var Drawer = function(menuId) {
		var raphael = Raphael("id_main_top_win_help_panel", 1150, 790);
		var panel = Ext.get("id_main_top_win_help_panel");
		var elementSet = new Array();
		var type = "";
		var nr = raphael.rect(10 , 10, 20, 20).attr({"fill" : "#000"}); // rect
		var nc = raphael.circle(50 , 20, 10).attr({"fill" : "#000"});   // circle
		var na = raphael.set();
			na.push(raphael.rect(70 , 10, 20, 20).attr({"stroke-width" : 0, "fill-opacity" : 0, "fill" : "#000"}));
			na.push(raphael.path("M70,12h10v16h8v-2l4,2l-4,2v-2").attr({"stroke-width" : 2}));  // arrow
		
		var nx = raphael.rect(100 , 10, 20, 20, 3).attr({"fill" : "#000"});  // init select
		
		var nn = raphael.rect(5 , 5, 130, 30); // navi 영역
			
		
		nr.click(function() {
			nr.attr({"fill" : "#f00", "stroke" : "#f00"});
			nc.attr({"fill" : "#000", "stroke" : "#000"});
			na.attr({"stroke" : "#000"});
			nn.data('type', 'rect');
		});

		nc.click(function() {
			nr.attr({"fill" : "#000", "stroke" : "#000"});
			nc.attr({"fill" : "#f00", "stroke" : "#f00"});
			na.attr({"stroke" : "#000"});
			nn.data('type','circle');
		});

		na.click(function() {
			nr.attr({"fill" : "#000", "stroke" : "#000"});
			nc.attr({"fill" : "#000", "stroke" : "#000"});
			na.attr({"stroke" : "#f00"});
			nn.data('type','arrow');
		});
		
		nx.click(function() {
			nr.attr({"fill" : "#000","stroke" : "#000"});
			nc.attr({"fill" : "#000","stroke" : "#000"});
			na.attr({"stroke" : "#000"});
			nn.data('type','');
		});

		
		(function(raphael, p, n, r, c, a) { // panel, navigator, rect, circle
				
			if( n.data('type') != '' ) {
				p.on('mousedown', function(e, t, eOpts){ 
					// alert( e.getX() +":"+ p.getX() +":"+ e.getY() +":"+ p.getY());
					if( !((e.getX() - p.getX()) > 5 && (e.getX() - p.getX()) < 130 &&  (e.getY()- p.getY()) > 5 && (e.getY()- p.getY()) < 30) ) {
						if( n.data('type') == 'rect' ) {
							rectangular(e, t, eOpts);
						} else if( n.data('type') == 'circle' ) {
							circle(e, t, eOpts);
						} else if( n.data('type') == 'arrow' ) {
							arrow(e, t, eOpts);
						}
						n.data('type','');
						r.attr({"fill" : "#000","stroke" : "#000"});
						c.attr({"fill" : "#000","stroke" : "#000"});
						a.attr({"stroke" : "#000"});
					}
				});
				p.on('keydown', function(e, t, eOpts){
					if( e.getKey() == Ext.EventObject.DELETE ) {
						raphael.getById( nn.data('selectedId') ).remove();
						elementSet[""+nn.data('selectedId')].remove();
					}
				})
			}
			
		})(raphael, panel, nn, nr, nc, na );
		
		
		// panel.on('mousedown', function(){alert(type)});
		//panel.on('mousedown', rectangular);
		//panel.on('mousedown', circle);
		
		/*
		 * rect element생성
		 */
		function rectangular(e, t, eOpts) {
			
			var rt = raphael.rect(e.getX()-panel.getX() , e.getY()-panel.getY(), 100, 20, 2);
			rt.attr({"fill" : "#fff", "stroke": "#0ff"});
			elementSet[""+rt.id]  = raphael.set();

			var ct = raphael.circle(rt.attr("x") + rt.attr("width")/2, rt.attr("y"), 4).attr({"fill" : "#000"}).data({'iam' : 'ct'}).data({'parent' : rt.id});
			var cr = raphael.circle(rt.attr("x") + rt.attr("width"), rt.attr("y") + rt.attr("height")/2 , 4).attr({"fill" : "#000"}).data({'iam' : 'cr'}).data({'parent' : rt.id});
			var cb = raphael.circle(rt.attr("x") + rt.attr("width")/2, rt.attr("y") + rt.attr("height") , 4).attr({"fill" : "#000"}).data({'iam' : 'cb'}).data({'parent' : rt.id});
			var cl = raphael.circle(rt.attr("x") , rt.attr("y") + rt.attr("height")/2 , 4).attr({"fill" : "#000"}).data({'iam' : 'cl'}).data({'parent' : rt.id});;
			
			(function(p, r, c_t, c_r, c_b, c_l) { // panel, rect, c
				var rx = r.attr('x');
				var ry = r.attr('y');
				var rb = r.attr('y') + r.attr('height');
				var rr = r.attr('x') + r.attr('width');
				
				// rect drag -> 이동
				r.drag(function(dx, dy, x, y, e){
					r.attr({'x': rx + dx, 'y' :  ry + dy });
					setCirclePosition();
				},function(x, y, e){
				},function(e){
					rx = r.attr('x');
					ry = r.attr('y');
					rb = r.attr('y') + r.attr('height');
				});
				
				// rect 위쪽 circle -> height resize
				c_t.drag(function(dx, dy, x, y, e){
					if( rb-(y-p.getY()) > 5 ) {
						c_t.attr({'cy' :  y-p.getY()}); 
						r.attr({'y' :  y-p.getY() , "height" : rb-(y-p.getY())});
						setCirclePosition();
					} else {
						// r.attr({"height" : y-p.getY()-r.attr("y")});
					}
				},function(x, y, e){
					rb = r.attr('y') + r.attr('height');
				},function(e){
					rx = r.attr('x');
					ry = r.attr('y');
					rb = r.attr('y') + r.attr('height');
					rr = r.attr('x') + r.attr('width');
				});
				
				// rect 오른쪽 circle -> width resize
				c_r.drag(function(dx, dy, x, y, e){
					if( x-p.getX()-r.attr("x") > 5 ) {
						c_r.attr({'cx' :  x-p.getX()}); 
						r.attr({"width" : x-p.getX()-r.attr("x")});
						setCirclePosition();
					} else {
						// r.attr({"height" : y-p.getY()-r.attr("y")});
					}
				},function(x, y, e){
					rr = r.attr('x') + r.attr('width');
				},function(e){
					rx = r.attr('x');
					ry = r.attr('y');
					rb = r.attr('y') + r.attr('height');
					rr = r.attr('x') + r.attr('width');
				});
				
				// rect 아래쪽  circle -> height resize
				c_b.drag(function(dx, dy, x, y, e){
					if( y-p.getY()-r.attr("y") > 5 ) {
						c_b.attr({'cy' :  y-p.getY()});
						r.attr({"height" : y-p.getY()-r.attr("y")});
						setCirclePosition();
					} else {
						// r.attr({'y' :  y-p.getY() , "height" : rb-(y-p.getY())});
					}
					
				},function(x, y, e){
					rb = r.attr('y') + r.attr('height');
				},function(e){
					rx = r.attr('x');
					ry = r.attr('y');
					rb = r.attr('y') + r.attr('height');
					rr = r.attr('x') + r.attr('width');
				});
				
				// rect 왼쪽 circle -> width resize
				c_l.drag(function(dx, dy, x, y, e){
					if( rr-(x-p.getX()) > 5 ) {
						c_l.attr({'cx' :  x-p.getX()}); 
						r.attr({'x' :  x-p.getX() , "width" : rr-(x-p.getX())});
						setCirclePosition();
					} else {
						// r.attr({"height" : y-p.getY()-r.attr("y")});
					}
				},function(x, y, e){
					rr = r.attr('x') + r.attr('width');
				},function(e){
					rx = r.attr('x');
					ry = r.attr('y');
					rb = r.attr('y') + r.attr('height');
					rr = r.attr('x') + r.attr('width');
				});
				
				//  rect 상우하좌 circle hover시 show / hide
				for( var x=2; x<arguments.length;x++) {
					arguments[x].hover(function(){
						elementSet[""+r.id].show();
					}, function(){
						elementSet[""+r.id].hide();
					});
					arguments[x].click(function() {
						elementSet[""+rt.id].show();
					});

				}

				// 상하좌우 circle위치 중간으로 계속 이동..
				function setCirclePosition() {
					c_t.attr({'cx' : r.attr("x") + r.attr("width")/2, 'cy' :  r.attr("y")});
					c_r.attr({'cx' : r.attr("x") + r.attr("width"), 'cy' :  r.attr("y") + r.attr("height")/2});
					c_b.attr({'cx' : r.attr("x") + r.attr("width")/2, 'cy' :  r.attr("y") + r.attr("height")});
					c_l.attr({'cx' : r.attr("x"), 'cy' :  r.attr("y") + r.attr("height")/2});					
				}
			})(panel, rt, ct, cr, cb, cl);
			
			elementSet[""+rt.id].push(ct);
			elementSet[""+rt.id].push(cr);
			elementSet[""+rt.id].push(cb);
			elementSet[""+rt.id].push(cl);

			elementSet[""+rt.id].hide();
			
			(function(square) {
				square.click(function(){
					square.data('selected', !square.data('selected') );
					nn.data('selectedId',square.id);
					elementSet[""+square.id].show();
				});
			})(rt);
			
			(function(square) {
				square.hover(function(){
					if( elementSet[""+square.id].length > 0 ) {
						elementSet[""+square.id].show();
					}
				}, function(){
					if(!square.data('selected')) {
						elementSet[""+square.id].hide();
					}
				});

			})(rt);
			
			
		}
		
		/*
		 * circle element생성
		 */
		function circle(e, t, eOpts) {
			raphael.circle(e.getX()-panel.getX() , e.getY()-panel.getY(), 10).attr({"fill" : "#fff", "stroke": "#0ff"});
		}
		
		/**
		 * 화살표 선긋기
		 */
		function arrow(e, t, eOpts) {
			var se = raphael.getElementByPoint(e.getX() , e.getY()); // 시작점 element
			var es = raphael.set(), ee, er ;  // 종료 element, 종료 점 중간에 rect
			var lpath = new Array(), epath = new Array();
			if(se.data('iam')  == 'cr') {
				
				epath.push("M" + (se.attr("cx")+100) +","+(se.attr("cy")+50));
				epath.push("v-2");
				epath.push("l10,2");
				epath.push("l-10,2z");
				
				ee = raphael.path(epath.join(',')).attr({'fill':'#000'}).data("x",(se.attr("cx")+100)).data("y",(se.attr("cy")+50));
				
				(function(_raphael, _ee) {
					this.ox = 0;
					this.oy = 0;
					
					_ee.drag(function(dx, dy, x, y, e){
						var trans_x = dx-this.ox;
					    var trans_y = dy-this.oy;
					    this.translate(trans_x,trans_y);
					    this.ox = dx;
					    this.oy = dy;
					    
					},function(x, y, e){
						
					},function(e){
						this.ox = 0;
						this.oy = 0;
						//rx = _er.attr('x');
						//ry = _er.attr('y');
					});
				})(raphael, ee);
				
				lpath.push("M" + se.attr("cx")+","+se.attr("cy"));
				lpath.push("h" + (ee.data("x") - se.attr("cx"))/2);
				lpath.push("v" + (ee.data("y") - se.attr("cy")));
				lpath.push("h" + (ee.data("x") - se.attr("cx"))/2);

				raphael.path(lpath.join(','));
			}
			// 우측면 circle일 경우.
		}
	}
})(window.Raphael);


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
            			// initRaphael(_this.up('window').menuId);
            			Raphael.drawer(_this.up('window').menuId);
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


function initRaphael(menuId) {

}


function drawShape(e, t, eOpts) {
	
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