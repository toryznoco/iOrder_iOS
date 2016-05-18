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

}
