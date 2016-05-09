package cn.net.normcore.iorder.action;

import java.util.HashMap;
import java.util.Map;

public class ShopAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3136724295847098471L;
	private Map<String, Object> json = new HashMap<String, Object>();
	private double userLat; // 用户所在位置纬度
	private double userLng; // 用户所在位置经度
	private int startId;
	private int amount;
	private int shopId;

	public String getShopDishesInfo() {
		json.put("shopDishes",
				getServMgr().getShopService().getShopDishes(shopId));
		return "jsonResult";
	}
	
	public String getNearestShops() {
		json.put(
				"shops",
				getServMgr().getShopService().callNearestShops(userLat,
						userLng, startId, amount));
		return "jsonResult";
	}

	public Map<String, Object> getJson() {
		return json;
	}

	public void setUserLat(double userLat) {
		this.userLat = userLat;
	}

	public void setUserLng(double userLng) {
		this.userLng = userLng;
	}

	public void setStartId(int startId) {
		this.startId = startId;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public void setShopId(int shopId) {
		this.shopId = shopId;
	}

}
