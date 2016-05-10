package cn.net.normcore.iorder.service;

public class ServiceManager {
	private ShopService shopService;
	private UserService userService;
	private DishesService dishesService;

	public ShopService getShopService() {
		return shopService;
	}

	public void setShopService(ShopService shopService) {
		this.shopService = shopService;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public DishesService getDishesService() {
		return dishesService;
	}

	public void setDishesService(DishesService dishesService) {
		this.dishesService = dishesService;
	}
}
