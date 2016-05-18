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

}
