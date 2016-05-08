package cn.net.normcore.iorder.service;

public class ServiceManager {
	private ShopService shopService;

	public ShopService getShopService() {
		return shopService;
	}

	public void setShopService(ShopService shopService) {
		this.shopService = shopService;
	}
}
