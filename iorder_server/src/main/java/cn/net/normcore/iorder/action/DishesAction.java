package cn.net.normcore.iorder.action;

import java.util.HashMap;
import java.util.Map;

public class DishesAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1922647820744918087L;
	private Map<String, Object> json = new HashMap<String, Object>();
	private int userId;
	private int dishesId;
	private int amount;
	private int couponId;
	private int shopId;
	private int orderId;

	public String pay() {
		getServMgr().getDishesService().updateOrderPay(orderId);
		return NONE;
	}

	public String getOrderDetail() {
		json.put("orderItems",
				getServMgr().getDishesService().getOrderItems(orderId));
		json.put("orderPrice",
				getServMgr().getDishesService().getOrderPrice(orderId));
		return "jsonResult";
	}

	public String order() {
		getServMgr().getDishesService().addOrder(userId, shopId, couponId);
		return NONE;
	}
	
	public String removeFromCart() {
		getServMgr().getDishesService().removeFromCart(userId, dishesId, amount);
		return NONE;
	}

	public String addToCart() {
		getServMgr().getDishesService().addToCart(userId, dishesId, amount);
		return NONE;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setDishesId(int dishesId) {
		this.dishesId = dishesId;
	}

	public void setCouponId(int couponId) {
		this.couponId = couponId;
	}

	public void setShopId(int shopId) {
		this.shopId = shopId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public Map<String, Object> getJson() {
		return json;
	}

}
