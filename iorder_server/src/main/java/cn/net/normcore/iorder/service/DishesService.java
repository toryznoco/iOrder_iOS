package cn.net.normcore.iorder.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

public class DishesService extends BaseService {

	public void addToCart(int userId, int dishesId, int amount) {
		// TODO Auto-generated method stub
		String sqlAddToCart = "INSERT INTO order_item(u_id, d_id, amount) VALUES(?, ?, ?)";
		String sqlFindSameItem = "SELECT id FROM order_item WHERE u_id = ? AND d_id = ? AND `status` = 1";
		String updateOldItem = "UPDATE order_item SET amount = amount + ? WHERE id = ?";

		try {
			int oldId = jt.queryForObject(sqlFindSameItem, Integer.class,
					userId, dishesId);
			jt.update(updateOldItem, amount, oldId);
		} catch (DataAccessException e) {
			// TODO Auto-generated catch block
			jt.update(sqlAddToCart, userId, dishesId, amount);
		}
	}

	public int addOrder(int userId, int shopId, int couponId) {
		// TODO Auto-generated method stub
		String sqlAddOrder = "INSERT INTO `order`(u_id, s_id, total_price, coup_id) VALUES(?, ?, (SELECT SUM(amount * price) FROM order_item oi INNER JOIN dishes d ON oi.d_id = d.id WHERE oi.`status` = 1 AND d.s_id = ?), ?)";
		String sqlUpdateItem = "UPDATE order_item SET o_id = ?, `status` = 2 WHERE `status` = 1 AND d_id IN (SELECT id FROM dishes WHERE s_id = ?)";
		String sqlGetOrderId = "SELECT id FROM `order` WHERE u_id = ? AND `status` = 1 ORDER BY create_time DESC LIMIT 1";

		jt.update(sqlAddOrder, userId, shopId, shopId, couponId == 0 ? null : couponId);
		int orderId = jt.queryForObject(sqlGetOrderId, new Object[] { userId },
				Integer.class);
		jt.update(sqlUpdateItem, orderId, shopId);
		return orderId;
	}

	public Object getOrderPrice(int orderId) {
		// TODO Auto-generated method stub
		String sqlGetOrderPrice = "SELECT total_price AS orderPrice FROM `order` WHERE id = ?";
		return jt.queryForObject(sqlGetOrderPrice, new Object[] { orderId },
				Object.class);
	}

	public List<Map<String, Object>> getOrderItems(int orderId) {
		// TODO Auto-generated method stub
		String sqlGetOrderItems = "SELECT d.`name` AS dishesName, oi.amount AS dishesAmt, d.price * oi.amount AS itemPrice FROM `order` o INNER JOIN order_item oi ON o.id = oi.o_id INNER JOIN dishes d ON d.id = oi.d_id WHERE o.id = ?";
		return jt.queryForList(sqlGetOrderItems, orderId);
	}

	private static final String SQL_REMOVE_FROM_CART = "UPDATE order_item SET amount = amount - ? WHERE u_id = ? AND d_id = ? AND `status` = 1";
	private static final String SQL_DELETE_ORDER_ITEM = "DELETE FROM order_item WHERE u_id = ? AND d_id = ? AND amount = 0";

	public void removeFromCart(int userId, int dishesId, int amount) {
		// TODO Auto-generated method stub
		jt.update(SQL_REMOVE_FROM_CART, amount, userId, dishesId);
		jt.update(SQL_DELETE_ORDER_ITEM, userId, dishesId);
	}

}
