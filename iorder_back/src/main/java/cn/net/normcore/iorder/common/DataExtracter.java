package cn.net.normcore.iorder.common;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

public interface DataExtracter {
	Map<String, Object> extractData(ResultSet rst) throws SQLException;
}
