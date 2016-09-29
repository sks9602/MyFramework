<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>


<jun:printScriptOut>
	function fs_v_list_cellclick() {
	
	}
</jun:printScriptOut>	

<jun:functions  targetId="search_1">
	<jun:function action="탭생성">
	/*
	Ext.create('widget.uxNotification', {
		title: 'Notification',
		position: 'br',
		manager: 'demo1',
		iconCls: 'ux-notification-icon-information', // 'ux-notification-icon-error',
		autoCloseDelay: 3000,
		spacing: 20,
		html: 'Entering from the component\'s br corner. 3000 milliseconds autoCloseDelay.<br />Increasd spacing.'
	}).show();
	*/

	if( !Ext.getCmp('v_detail_list')) {
		fs_AddTab_v_detail_list();
	}
	Ext.getCmp('id_main_tabpanel').setActiveTab('v_detail_list');

	if( !Ext.getCmp('v_list_tab_list')) {
		fs_AddTab_v_list_tab_list();
	}

	if( !Ext.getCmp('v_detail')) {
		fs_AddTab_v_detail();
	}	
	
	if( !Ext.getCmp('v_tree_detail')) {
		fs_AddTab_v_tree_detail();
	}	

	if( !Ext.getCmp('v_tpl')) {
		fs_AddTab_v_tpl();
	}	
	
	var cmpTpl = Ext.getCmp('v_tpl_detail_form_1');

	var dt = new Date('1/10/2016 03:05:01 PM GMT-0600');

	for( var x=0 ; x<5; x++) {
		var dt1 = Ext.Date.add(dt, Ext.Date.DAY, x);
		
		var itemGrid = 
		<jun:item>
			<jun:section title="2016.08.17 (수요일)" maxItem="4" id="random">
				<jun:itemText  type="text"  id="random" name="mail11" title="E-mail"  vtype="email" colspan="4"></jun:itemText>
				<jun:itemGrid id="random" action="/example/example.do" page="5" fields="Sample.selectTableList" width="800" height="200" editable="Y" position="sub"> <!--  lead="checkbox"  -->
					<jun:columns>
						<jun:column title="이름" column="TNAME"  width="150" align="left" ></jun:column>
						<jun:column title="이름2" column="TABLE_NAME" width="150"></jun:column>
						<jun:column title="설명" column="TABLE_COMMENTS" flex="1" align="left" width="100" editor="textfield">
							<jun:columnText type="text" require="Y"></jun:columnText>
						</jun:column>
					</jun:columns>
				</jun:itemGrid>
			</jun:section>
		</jun:item>;
		
		itemGrid.setTitle( Ext.Date.format(dt1, 'Y.m.d (D)') );
		
		if( x != 0  ) {
			itemGrid.collapse();
		}
		
		cmpTpl.add( itemGrid );	
	}

	Ext.getCmp('v_list_tab_list_data_dtl_html').update( 'html<br/>html2' );
	
	/*
	if( !Ext.getCmp('v_auth_menu')) {
		fs_AddTab_v_auth_menu();
		
		// Ext.getCmp('id_main_tabpanel').setActiveTab('v_auth_menu');
	}
	
	if( !Ext.getCmp('v_treelist_auth')) {
		fs_AddTab_v_treelist_auth();
		
		// Ext.getCmp('id_main_tabpanel').setActiveTab('v_treelist_auth');
	}
	
	if( !Ext.getCmp('v_treelist_detail')) {
		fs_AddTab_v_treelist_detail();
		
		Ext.getCmp('id_main_tabpanel').setActiveTab('v_treelist_detail');
	}
	*/
	</jun:function>

	<jun:function action="파일다운로드">
		fs_FileDownLoad('1');
	</jun:function>

	<jun:function action="엑셀다운로드">
		fs_ExcelDownLoad('1');
	</jun:function>
	
	<jun:function action="권한Reload">
	</jun:function>	
	

</jun:functions>


<jun:functions  targetId="grid_1">
	<jun:function action="저장">
	
	var grid_1 = Ext.getCmp('v_list_grid_grid_1');
	// grid_1.submit( submitType,actionFlag, option);
	grid_1.submit('changed', 'v_list_detail_form1',
		{
			callback : function() {
				store.reload()
			}, 
			success : function(batch, option) {
				alert('성공');
			}, 
			failure : function() {
			 	alert('실패');
			}
		}
	) ;
		
	</jun:function>	
	
	<jun:function action="상세조회"  args="table_name"  url="/example/example.do?p_action_flag=r_detail" fields="Sample.selectTableInfo">
	fs_AddTab_v_tree_detail(args);
	
	Ext.getCmp('id_main_tabpanel').setActiveTab('v_tree_detail');

	store.on("load", function(_this, _records, _successful, _eOpts ) {

		var form = Ext.getCmp('v_tree_detail_detail_dtl_1');
		//for( var i in  _records[0].data ) {
			// alert( i );
		//}

        form.loadRecord(_records[0]);
        
        <jun:element name="FORUPDATE" actionFlag="v_tree_detail" targetId="dtl_1">
        	FORUPDATE.update( _records[0].data.ANIMAL );
        </jun:element>
        
        // UPDATE  함.
        // Ext.get('v_tree_detail_dtl_1_FORUPDATE').update(_records[0].data.ANIMAL);
        
        
        // Outline.all_in_one.jsp에 선언됨.
        makeProcess(_records[0].data);
	});
	
	// Ext.getCmp('id_main_tabpanel').setTitle('[' +args.TABLE_NAME +'] has Selected... (Example.v_list.jsp의 클릭에서 Title변경..)');

		<jun:element name="MAIN_TABPANEL" id="id_main_tabpanel" func="cmp">
			MAIN_TABPANEL.setTitle('[' +args.TABLE_NAME +'] has Selected... (Example.v_list.jsp의 클릭에서 Title변경..)');
		</jun:element>

	</jun:function>
</jun:functions>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:form section="search"  button="조회,탭생성,파일다운로드,엑셀다운로드,권한Reload"  id="search_1" action="/example/example.do" gridId="grid_1" position="north" delay="Y">
			<jun:itemText  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:itemText>
			<jun:itemText  type="text"   name="mail" title="E-mail"  vtype="email" ></jun:itemText><!-- unit="건"  -->
			<jun:itemAProject  type="member"   name="member" title="회원검색" ></jun:itemAProject><!-- unit="건"  -->
			<jun:itemAjax  type="combo"  name="combo" title="Ajax타이틀"  groupCode="SYS001"  multiSelect="Y" page="20"  value="HR_ABL" dependsNames="ABILITY_GBN"></jun:itemAjax>
			<jun:itemCode  type="combo"  name="ABILITY_GBN" title="타이틀"  groupCode="SYS001" first="all" multiSelect="Y"  value="SYS001001,SYS001002">
				displayTpl: '<tpl for=".">{[xindex > 1 ? "," : ""]}{NAME}-{VALUE}</tpl>',
			</jun:itemCode>
			<jun:itemText  type="text"   name="table_nm" title="알파뱃만"  vtype="alphanew"      ></jun:itemText>
			<jun:itemText  type="text"   name="text_nm" title="숫자만"    vtype="numericpos"   ></jun:itemText>
			<jun:itemNumber  type="scope"   name="ORDER_NO" title="scope"  value="3,1080"   min="0" max="10000" thousand="Y" scale="5,2"></jun:itemNumber> <!-- unit="%"   -->
			<jun:itemNumber  type="slider"   name="Slider" title="slider"  value="3,80"   min="0" max="100" ></jun:itemNumber> <!-- unit="%"   -->
			<jun:itemDate  type="period"  name="edu_dt" title="학습시작일" value="-3m, 3Week"></jun:itemDate>
			<jun:itemTree  type="tree"  name="title2" title="타이틀"  groupCode="SYS001"></jun:itemTree>
		</jun:form>
		<jun:form section="detail" action="/example/example.do" gridId="grid_1" hidden="Y" id="form1">
			<jun:itemText  type="text"   name="table_nm" title="테이블명"       ></jun:itemText>
			<jun:itemText  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:itemText>
			<jun:itemText  type="text"   name="mail" title="E-mail"       ></jun:itemText>
		</jun:form>
		<jun:data>
			<jun:grid id="grid_1" action="/example/example.do" button="저장" page="5" fields="Sample.selectTableList" groupTpl="" groupName="" listeners="cellclick:fs_v_list_cellclick" editable="Y"> <!--  lead="checkbox"  -->
				<jun:toolbars>
					<jun:toolbar_detail  type="combotipple_ux"  name="" title="타이틀"  groupCode="SYS001" first="none"></jun:toolbar_detail>
					<jun:toolbar_detail  type="button"  name="" title="타이틀" ></jun:toolbar_detail>
				</jun:toolbars>
				<jun:columns>
					<jun:column title="이름" column="TNAME"  width="150" align="left" >
						renderer : function (value, p, record){
							return Ext.String.format(
								<jun:link action="상세조회" targetId="grid_1" args="'{0}'"></jun:link>,
							value,
							record.data.TNAME,
							p );
						},
					</jun:column>
					<jun:column title="이름2" column="TABLE_NAME" width="150"></jun:column>
					<jun:column title="설명" column="TABLE_COMMENTS" flex="1" align="left" width="100" editor="textfield">
						<jun:columnText type="text" require="Y"></jun:columnText>
					</jun:column>
					<jun:column title="Grid Editor" column="email0" width="100" resize="N" sortable="N" editor="combogrid">
						editor : {
							xtype      : 'combogrid'
						},
					</jun:column>
					<jun:column title="Combo Editor" column="email2" width="100" resize="N" sortable="N"  editor="combotipple" >
						<jun:columnCode type="combo" groupCode="SYS001"  ></jun:columnCode>
					</jun:column>
					<jun:column title="Tree Editor" column="owner" width="100" resize="N" sortable="N"  editor="combotree">
						<jun:columnTree type="combo" groupCode="SYS001"  ></jun:columnTree>
					</jun:column>
					<jun:column title="E-Mail" column="email" width="100" resize="N" sortable="N" editor="email" >
						<jun:columnText type="text" require="Y" vtype="email"></jun:columnText>
					</jun:column>
					<jun:column title="컬럼 여부" column="COLUMN_YN" id="v_list_Tname_2" width="100" editor="checkbox:TNAME" storeId="v_list_store_grid_grid_1"></jun:column>
					<jun:column title="컬럼 여부(bool)" column="COLUMN_YN_BOOL" id="v_list_Tname_3" width="100" editor="checkbox:TNAME" storeId="v_list_store_grid_grid_1"></jun:column>
					<jun:column title="팩스" column="fax_number"  width="100" editor="numberfield, minValue:10, maxValue:100"  renderer="rowspanRenderer"></jun:column>
					<jun:columnGrp title="연락처">
						<jun:column title="COLUMN_YN" column="COLUMN_YN"  width="100"></jun:column>
						<jun:column title="COLUMN_YN_BOOL" column="COLUMN_YN_BOOL"  width="100"></jun:column>
						<jun:column title="OWNER" column="OWNER"  width="100" >
						</jun:column>
					</jun:columnGrp>
				</jun:columns>
				<jun:objects name="viewConfig">
			            stripeRows: true,
			            enableTextSelection: true, // grid에서.. select가능하게...
			            plugins: {
			                ptype: 'gridviewdragdrop',
			                dragGroup: 'firstGridDDGroup',
			                dropGroup: 'firstGridDDGroup',
			                ddGroup: 'firstGridDDGroup',
			                dragText: 'For more information...'
			            }
				</jun:objects>
			</jun:grid>
		</jun:data>
	</jun:data>
</jun:body>