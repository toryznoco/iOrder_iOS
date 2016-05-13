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
		String sqlGetUserOrders = "SELECT s.id AS shopId, o.`status` AS `status`, `name` AS shopName, SUM(oi.amount) AS dishesAmt, o.total_price AS price, create_time AS time FROM `order` o INNER JOIN shop s ON s_id = s.id INNER JOIN order_item oi ON o.id = o_id WHERE o.u_id = ? GROUP BY o.id";
		return jt.query(sqlGetUserOrders, new Object[] { userId },
				new ResultSetExtractor<List<Map<String, Object>>>() {

					@Override
					public List<Map<String, Object>> extractData(ResultSet rs)
							throws SQLException, DataAccessException {
						// TODO Auto-generated method stub
						List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
						while (rs.next()) {
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("shopId", rs.getString("shopId"));
							map.put("status", rs.getInt("status"));
							map.put("shopName", rs.getString("shopName"));
							map.put("dishesAmt", rs.getInt("dishesAmt"));
							map.put("price", rs.getObject("price"));
							map.put("time", rs.getTimestamp("time"));
							list.add(map);
						}
						return list;
					}
				});
	}

}
