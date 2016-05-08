package cn.net.normcore.iorder.action;

import java.util.List;
import java.util.Map;

public class ShopAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3136724295847098471L;
	private List<Map<String, Object>> shops;
	private double userLat; // 用户所在位置纬度
	private double userLng; // 用户所在位置经度
	private int startId;
	private int amount;
	private int shopId;
	private List<Map<String, Object>> shopDishes;

	public String getShopDishesInfo() {
		shopDishes = getServMgr().getShopService().getShopDishes(shopId);
		return "shopDishes";
	}

	public String getNearestShops() {
		shops = getServMgr().getShopService().callNearestShops(userLat,
				userLng, startId, amount);
		return "shops";
	}

	public List<Map<String, Object>> getShops() {
		return shops;
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

	public List<Map<String, Object>> getShopDishes() {
		return shopDishes;
	}

}
