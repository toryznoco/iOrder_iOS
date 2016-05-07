package cn.net.normcore.iorder.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.net.normcore.iorder.common.DataExtracter;

public class ShopService extends BaseService {

	public List<Map<String, Object>> callNearestShops(double userLat,
			double userLng, int startId, int amount) {
		// TODO Auto-generated method stub
		return cst.callForList("call getNearestShops(?, ?, ?, ?)",
				new Object[] { startId, amount, userLng, userLat },
				new DataExtracter() {

					@Override
					public Map<String, Object> extractData(ResultSet rst)
							throws SQLException {
						// TODO Auto-generated method stub
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("name", rst.getString("name"));
						map.put("cheap", rst.getString("cheap"));
						map.put("picture", rst.getString("picture"));
						map.put("score", rst.getInt("score"));
						map.put("perPri", rst.getFloat("perPri"));
						map.put("toSal", rst.getInt("toSal"));
						map.put("distance", rst.getInt("distance"));
						return map;
					}
				});
	}

}
