package cn.net.normcore.iorder.util;

public class MapDistance {

	private static final double EARTH_RADIUS = 6378.137; // 赤道半径，单位KM

	/**
	 * 角度转弧度
	 * 
	 * @param d
	 * @return
	 */
	private static double rad(double d) {
		return d * Math.PI / 180.0;
	}

	/**
	 * 计算两点间的距离
	 * 
	 * @param lat1
	 *            点1经度
	 * @param lng1
	 *            点1纬度
	 * @param lat2
	 *            点2经度
	 * @param lng2
	 *            点2纬度
	 * @return 点1和点2之间的距离，单位M
	 */
	public static int getDistance(double lat1, double lng1, double lat2,
			double lng2) {
		double radLat1 = rad(lat1);
		double radLat2 = rad(lat2);
		double difference = radLat1 - radLat2;
		double mdifference = rad(lng1) - rad(lng2);
		double distance = 2 * Math.asin(Math.sqrt(Math.pow(
				Math.sin(difference / 2), 2)
				+ Math.cos(radLat1)
				* Math.cos(radLat2)
				* Math.pow(Math.sin(mdifference / 2), 2)));
		distance = distance * EARTH_RADIUS;
		distance = Math.round(distance * 10000) / 10000;

		return (int) difference;
	}

}
