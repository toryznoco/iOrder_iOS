package cn.net.normcore.iorder.action;

import java.util.HashMap;
import java.util.Map;

public class OrderAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1562977516032683826L;
	private Map<String, Object> json = new HashMap<String, Object>();
	private int orderId;
	private int userId;
	private int shopId;

	public String getCart() {
		json.put("itmes", getServMgr().getOrderService()
				.getCart(userId, shopId));
		json.put("totalPri",
				getServMgr().getOrderService().getCartTotalPri(userId, shopId));
		return "jsonResult";
	}

	public String pay() {
		getServMgr().getOrderService().pay(orderId);
		return NONE;
	}

	public String getOrderStatusRecord() {
		json.put("orderStatus", getServMgr().getOrderService()
				.getOrderStatusRecord(orderId));
		return "jsonResult";
	}

	public Map<String, Object> getJson() {
		return json;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setShopId(int shopId) {
		this.shopId = shopId;
	}

}
