package cn.net.normcore.iorder.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderService extends BaseService {

	private static final String SQL_GET_ORDER_TIME = "SELECT create_time FROM `order` WHERE id = ?";
	private static final String SQL_GET_ORDER_STATUS_RECORD = "SELECT `status`, time FROM order_status_record WHERE o_id = ?";

	public List<Map<String, Object>> getOrderStatusRecord(int orderId) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("time",
				jt.queryForObject(SQL_GET_ORDER_TIME, Object.class, orderId));
		map.put("status", 1);
		list.add(map);
		list.addAll(jt.queryForList(SQL_GET_ORDER_STATUS_RECORD, orderId));
		return list;
	}

	private static final String SQL_PAY_WITH_COUPON = "UPDATE `order` o SET o.`status` = 2, o.pay_time = NOW(), o.pay_price = o.total_price - (SELECT c.money FROM coupon c WHERE c.id = o.coup_id) WHERE o.id = ?";
	private static final String SQL_PAY_WITHOUT_COUPON = "UPDATE `order` o SET o.`status` = 2, o.pay_time = NOW(), o.pay_price = o.total_price WHERE o.id = ?";
	private static final String SQL_GET_ORDER_COUPON = "SELECT coup_id FROM `order` WHERE id = ?";

	public void pay(int orderId) {
		// TODO Auto-generated method stub
		if (jt.queryForObject(SQL_GET_ORDER_COUPON, new Object[] { orderId },
				Integer.class) == null) {
			jt.update(SQL_PAY_WITHOUT_COUPON, orderId);
		} else {
			jt.update(SQL_PAY_WITH_COUPON, orderId);
		}
	}

	private static final String SQL_GET_CART = "SELECT d.`name` AS dishesName, d.price * oi.amount AS itemPrice, oi.amount FROM order_item oi INNER JOIN dishes d ON oi.d_id = d.id WHERE oi.u_id = ? AND d.s_id = ? AND `status` = 1";

	public List<Map<String, Object>> getCart(int userId, int shopId) {
		// TODO Auto-generated method stub
		return jt.queryForList(SQL_GET_CART, userId, shopId);
	}

	private static final String SQL_GET_CART_TOTAL_PRI = "SELECT SUM(d.price * oi.amount) AS totalPri FROM order_item oi INNER JOIN dishes d ON oi.d_id = d.id WHERE oi.u_id = ? AND d.s_id = ? AND `status` = 1";

	public Object getCartTotalPri(int userId, int shopId) {
		// TODO Auto-generated method stub
		return jt.queryForObject(SQL_GET_CART_TOTAL_PRI, new Object[] { userId,
				shopId }, Object.class);
	}

}
