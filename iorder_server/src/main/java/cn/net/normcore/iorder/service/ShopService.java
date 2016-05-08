package cn.net.normcore.iorder.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
						map.put("id", rst.getInt("id"));
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

	public List<Map<String, Object>> getShopDishes(int shopId) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

		String sqlGetShopCatg = "SELECT c.id, c.`name` FROM category c INNER JOIN shop_categ sc ON c.id = sc.c_id WHERE sc.s_id = ?";
		List<Map<String, Object>> shopCatgs = jt.queryForList(sqlGetShopCatg,
				shopId);

		String sqlGetCatgDishes = "SELECT `name`, praise_amount AS praAmt, comm_amount AS comAmt, month_sales AS monSal, price, picture FROM dishes WHERE s_id = ? AND c_id = ?";

		for (Map<String, Object> map : shopCatgs) {
			Map<String, Object> aCatg = new HashMap<String, Object>();
			aCatg.put("catgName", map.get("name"));
			aCatg.put("dishes",
					jt.queryForList(sqlGetCatgDishes, shopId, map.get("id")));
			result.add(aCatg);
		}

		return result;
	}

}
