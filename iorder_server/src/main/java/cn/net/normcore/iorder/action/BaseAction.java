package cn.net.normcore.iorder.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import cn.net.normcore.iorder.bean.BeanManager;
import cn.net.normcore.iorder.service.ServiceManager;

import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements ServletRequestAware,
		ServletResponseAware, SessionAware {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected final Log log = LogFactory.getLog(getClass());
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected Map<String, Object> session;

	public ServiceManager getServMgr() {

		return (ServiceManager) BeanManager.getBean("serviceManager");
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		session = arg0;
	}

	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		response = arg0;
	}

	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		request = arg0;
	}

}
