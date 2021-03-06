package cn.net.normcore.iorder.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

public class UserService extends BaseService {

	public Map<String, Object> getUserByName(String userName) {
		// TODO Auto-generated method stub
		String sqlGetUserByName = "SELECT id AS userId, `name` AS userName, `password` AS userPass, `level` AS userLevel FROM `user` WHERE `name` = ?";
		try {
			return jt.queryForObject(sqlGetUserByName,
					new RowMapper<Map<String, Object>>() {

						@Override
						public Map<String, Object> mapRow(ResultSet rs,
								int rowNum) throws SQLException {
							// TODO Auto-generated method stub
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("userId", rs.getInt("userId"));
							map.put("userName", rs.getString("userName"));
							map.put("userPass", rs.getString("userPass"));
							map.put("userLevel", rs.getInt("userLevel"));
							return map;
						}
					}, userName);
		} catch (DataAccessException e) {
			// TODO Auto-generated catch block
			log.info("用户名不存在：" + userName);
			return null;
		}
	}

	public List<Map<String, Object>> getOrders(int userId) {
		// TODO Auto-generated method stub
		String sqlGetUserOrders = "SELECT o.id AS ID, s.id AS shopId, o.`status` AS `status`, `name` AS shopName, s.picture AS shopPic, SUM(oi.amount) AS dishesAmt, o.total_price AS price, create_time AS time FROM `order` o INNER JOIN shop s ON s_id = s.id INNER JOIN order_item oi ON o.id = o_id WHERE o.u_id = ? GROUP BY o.id";
		return jt.query(sqlGetUserOrders, new Object[] { userId },
				new ResultSetExtractor<List<Map<String, Object>>>() {

					@Override
					public List<Map<String, Object>> extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						// TODO Auto-generated method stub
						List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
						while (rs.next()) {
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("ID", rs.getInt("id"));
							map.put("shopId", rs.getInt("shopId"));
							map.put("status", rs.getInt("status"));
							map.put("shopName", rs.getString("shopName"));
							map.put("shopPic", rs.getString("shopPic"));
							map.put("dishesAmt", rs.getInt("dishesAmt"));
							map.put("price", rs.getObject("price"));
							map.put("time", rs.getTimestamp("time").toString().replaceAll("T", ""));
							list.add(map);
						}
						return list;
					}
				});
	}

	public void addShopMark(int userId, int shopId) {
		// TODO Auto-generated method stub
		String sqlAddShopMark = "INSERT INTO mark_shop(u_id, s_id) VALUES(?, ?)";
		jt.update(sqlAddShopMark, userId, shopId);
	}

	public void addDishesMark(int userId, int dishesId) {
		// TODO Auto-generated method stub
		String sqlAddShopMark = "INSERT INTO mark_dish(u_id, d_id) VALUES(?, ?)";
		jt.update(sqlAddShopMark, userId, dishesId);
	}

	public void addSign(int userId, int shopId) {
		// TODO Auto-generated method stub
		String sqlSign = "INSERT INTO sign_in(u_id, s_id) VALUES(?, ?)";
		jt.update(sqlSign, userId, shopId);
	}

	public List<Map<String, Object>> getSginRecord(int userId, int shopId,
			int year, int month) {
		// TODO Auto-generated method stub
		String sqlGetSignRecord = "SELECT DAY(sign_time) AS `day` FROM sign_in WHERE u_id = ? AND s_id = ? AND YEAR(sign_time) = ? AND MONTH(sign_time) = ? ORDER BY sign_time";
		return jt.queryForList(sqlGetSignRecord, userId, shopId, year, month);
	}

}
