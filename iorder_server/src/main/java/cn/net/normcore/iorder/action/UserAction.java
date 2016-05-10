package cn.net.normcore.iorder.action;

import java.util.HashMap;
import java.util.Map;

import cn.net.normcore.iorder.util.InfoProtUtil;

public class UserAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4083613025301257127L;
	private Map<String, Object> json = new HashMap<String, Object>();
	private String userName;
	private String userPass;

	/**
	 * code：0用户名不存在 1登录成功 2密码错误
	 * 
	 * @return
	 */
	public String login() {
		Map<String, Object> user = getServMgr().getUserService().getUserByName(
				userName);
		if (user == null) {
			json.put("code", 0);
		}
		if (user != null) {
			if (InfoProtUtil.parseStrToMd5L32(userName + ":" + userPass)
					.equals(user.get("userPass"))) {
				json.put("code", 1);
				json.put("user", user);
			} else {
				json.put("code", 2);
			}
		}
		return "loginResult";
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public Map<String, Object> getJson() {
		return json;
	}

}
