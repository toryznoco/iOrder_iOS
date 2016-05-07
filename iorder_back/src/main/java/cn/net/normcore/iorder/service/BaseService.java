package cn.net.normcore.iorder.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.JdbcTemplate;

import cn.net.normcore.iorder.bean.BeanManager;
import cn.net.normcore.iorder.common.CallableStatementTemplate;

public class BaseService {
	protected final Log log = LogFactory.getLog(getClass());
	protected JdbcTemplate jt;
	protected CallableStatementTemplate cst;

	public void setJt(JdbcTemplate jt) {
		this.jt = jt;
	}

	public void setCst(CallableStatementTemplate cst) {
		this.cst = cst;
	}

	public ServiceManager getServMgr() {
		return (ServiceManager) BeanManager.getBean("serviceManager");
	}
}
