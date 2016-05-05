package cn.net.normcore.iorder.bean;

import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class BeanManager {
	protected static final Log log = LogFactory.getLog(BeanManager.class);
	private static WebApplicationContext wac;

	public static void init(ServletContext context) {
		wac = WebApplicationContextUtils
				.getRequiredWebApplicationContext(context);
		log.info("BeanManager init finished.");
	}

	public static Object getBean(String beanName) {
		return wac.getBean(beanName);
	}
}
