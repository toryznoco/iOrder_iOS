package cn.net.normcore.iorder.service;

public class DishesService extends BaseService {

	public void addToCart(int userId, int dishesId, int amount) {
		// TODO Auto-generated method stub
		String sqlAddToCart = "INSERT INTO order_item(u_id, d_id, amount) VALUES(?, ?, ?)";
		jt.update(sqlAddToCart, userId, dishesId, amount);
	}

}
