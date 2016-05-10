package cn.net.normcore.iorder.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class InfoProtUtil {

	public static String parseStrToMd5L32(String lainText) {
		String resultStr = null;
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			byte[] bytes = md5.digest(lainText.getBytes());
			StringBuffer stringBuffer = new StringBuffer();
			for (int i = 0; i < bytes.length; i++) {
				int bt = bytes[i] & 0xff;
				if (bt < 16) {
					stringBuffer.append(0);
				}
				stringBuffer.append(Integer.toHexString(bt));
			}

			resultStr = stringBuffer.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return resultStr;
	}
}
