package cn.net.normcore.iorder.bean;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class BeanManagerListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		BeanManager.init(arg0.getServletContext());
	}
}
