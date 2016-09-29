package com.base.system.action;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import project.jun.was.HoModel;
import project.jun.was.servlet.HoServlet;
import project.jun.was.parameter.HoParameter;

import com.base.system.delegate.DataBaseDelegate;

public class DataBaseAction extends ProjectAction {
	public Logger getLogger() {
		return Logger.getLogger(DataBaseAction.class);
	}

	public void printActionFlag(String actionFlag){
		getLogger().info(" actionFlag : " + actionFlag );
	}

	public Object execute(String actionFlag, HoModel model, HoParameter parameter, HoServlet   hoServlet) throws Exception {


		if(actionFlag.equals("db")) {
			this.setForwardPage("/jsp/common/system/Outline.db.jsp");

		}else if(actionFlag.equals("r_list")) {
			this.setForwardPage( (String) this.getHoConfig().getOutlineMap().get("BLANK") );

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			delegate.init(actionFlag, model, parameter, parameter.getHoConfig());
			// this.setForwardPage( this.getDefaultPageInfo().replace("#p_action_flag#", actionFlag));

		}else if(actionFlag.equals("b_make_table_info")){
			this.setForwardPage( (String) this.getHoConfig().getOutlineMap().get("DATA_JSON") );

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			delegate.makeTableInfo(actionFlag, model, parameter, parameter.getHoConfig());
			this.setForwardPage( "/system/dataBase.do?p_action_flag=r_list");
			//this.setForwardPage( this.getHoConfig().getOutlineMap().get("BLANK").toString());
			//this.setIncludePage( this.getDefaultPageInfo().replace("#p_action_flag#", "r_list"));
		}
		else if(actionFlag.equals("r_json_data")){
			this.setForwardPage( (String) this.getHoConfig().getOutlineMap().get("DATA_JSON") );

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			delegate.list(actionFlag, model, parameter, parameter.getHoConfig());
		}
		else if(actionFlag.equals("r_detail")){
			super.setForwardPage((String) this.getHoConfig().getOutlineMap().get("BLANK"));

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			delegate.detail(actionFlag, model, parameter, parameter.getHoConfig());
		}
		else if(actionFlag.equals("r_detail_option")){
			super.setForwardPage((String) this.getHoConfig().getOutlineMap().get("BLANK"));

		}
		else if(actionFlag.equals("r_query")){
			super.setForwardPage((String) this.getHoConfig().getOutlineMap().get("MAIN"));

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			delegate.detail(actionFlag, model, parameter, parameter.getHoConfig());
		}
		else if(actionFlag.indexOf("r_html")!=-1){
			super.setForwardPage((String) this.getHoConfig().getOutlineMap().get("MAIN"));

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			delegate.detail(actionFlag, model, parameter, parameter.getHoConfig());
		}
		else if(actionFlag.equals("r_join_table")){
			super.setForwardPage((String) this.getHoConfig().getOutlineMap().get("BLANK"));

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			// delegate.joinTable();
		}
		else if(actionFlag.equals("r_join")){
			super.setForwardPage((String) this.getHoConfig().getOutlineMap().get("BLANK"));

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			delegate.join(actionFlag, model, parameter, parameter.getHoConfig());
		}else if(actionFlag.equals("r_info")){
			super.setForwardPage((String) this.getHoConfig().getOutlineMap().get("BLANK"));

			DataBaseDelegate delegate = (DataBaseDelegate) super.getHoDelegate();

			delegate.detail(actionFlag, model, parameter, parameter.getHoConfig());
		}
		return null;
	}
}