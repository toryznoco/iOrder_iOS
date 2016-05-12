package cn.net.normcore.iorder.action;

public class DishesAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1922647820744918087L;
	private int userId;
	private int dishesId;
	private int amount;
	private int couponId;
	private int shopId;

	public String order() {
		getServMgr().getDishesService().addOrder(userId, shopId, couponId);
		return NONE;
	}

	public String addToCart() {
		getServMgr().getDishesService().addToCart(userId, dishesId, amount);
		return NONE;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setDishesId(int dishesId) {
		this.dishesId = dishesId;
	}

	public void setCouponId(int couponId) {
		this.couponId = couponId;
	}

	public void setShopId(int shopId) {
		this.shopId = shopId;
	}

}
