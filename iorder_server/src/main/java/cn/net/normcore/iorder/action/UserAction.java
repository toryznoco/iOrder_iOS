package cn.net.normcore.iorder.action;

import java.util.Calendar;
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
	private int userId;
	private int shopId;
	private int dishesId;
	private int year, month;

	public String getUserSignRecord() {
		if (year == 0 || month == 0) {
			Calendar calendar = Calendar.getInstance();
			if (year == 0) {
				year = calendar.get(Calendar.YEAR);
			}
			if (month == 0) {
				month = calendar.get(Calendar.MONTH) + 1;
			}
		}
		json.put(
				"sginRecord",
				getServMgr().getUserService().getSginRecord(userId, shopId,
						year, month));
		return "jsonResult";
	}

	public String signIn() {
		getServMgr().getUserService().addSign(userId, shopId);
		return NONE;
	}

	public String markDishes() {
		getServMgr().getUserService().addDishesMark(userId, dishesId);
		return NONE;
	}

	public String markShop() {
		getServMgr().getUserService().addShopMark(userId, shopId);
		return NONE;
	}

	public String getOrders() {
		json.put("orders", getServMgr().getUserService().getOrders(userId));
		return "jsonResult";
	}

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

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setShopId(int shopId) {
		this.shopId = shopId;
	}

	public void setDishesId(int dishesId) {
		this.dishesId = dishesId;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public void setMonth(int month) {
		this.month = month;
	}

}
