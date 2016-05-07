package cn.net.normcore.iorder.common;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.JdbcTemplate;

public class CallableStatementTemplate {
	private JdbcTemplate jt;

	public void setJt(JdbcTemplate jt) {
		this.jt = jt;
	}

	public List<Map<String, Object>> callForList(final String callSql,
			final Object[] params, final DataExtracter dataExtracter) {
		return jt.execute(callSql,
				new CallableStatementCallback<List<Map<String, Object>>>() {

					@Override
					public List<Map<String, Object>> doInCallableStatement(
							CallableStatement cs) throws SQLException,
							DataAccessException {
						// TODO Auto-generated method stub
						setParams(cs, params);
						cs.execute();
						List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
						ResultSet rst = cs.getResultSet();
						while (rst.next()) {
							list.add(dataExtracter.extractData(rst));
						}
						rst.close();
						return list;
					}
				});
	}

	private void setParams(CallableStatement cs, Object[] params)
			throws SQLException {
		if (params != null && params.length > 0) {
			for (int i = 0; i < params.length; i++) {
				cs.setObject(i + 1, params[i]);
			}
		}
	}
}
