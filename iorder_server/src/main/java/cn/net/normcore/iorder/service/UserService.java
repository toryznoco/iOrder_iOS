package cn.net.normcore.iorder.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DataAccessException;
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

}
