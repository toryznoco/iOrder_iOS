package cn.net.normcore.iorder.common.utils;

import org.springframework.util.StringUtils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 信息处理工具类
 * Created by 81062 on 2017/3/16.
 */
public class InfoUtils {

    public static String getMd5Password(String password, String salt) {
        return parseStrToMd5L32(password + salt);
    }

    /**
     * 将明文信息进行128位MD5加密
     *
     * @param lainText 需要加密的明文
     * @return 32位大写加密结果
     */
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
        return resultStr.toLowerCase();
    }

    /**
     * 获取随机MD5盐，8位
     *
     * @return
     */
    public static String getMd5Salt() {
        return getRandomText(8);
    }

    /**
     * 获取指定长度的随机字符串
     *
     * @param length
     * @return
     */
    public static String getRandomText(int length) {
        String baseChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuffer buffer = new StringBuffer();
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            buffer.append(baseChars.charAt(random.nextInt(baseChars.length())));
        }
        return buffer.toString();
    }

    /**
     * 判断字符串是否为手机号码格式
     *
     * @param text
     * @return
     */
    public static boolean isMobileNo(String text) {
        if (StringUtils.isEmpty(text))
            return false;
        Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(14[57])|(17[0])|(17[7])|(18[0,0-9]))\\d{8}$");
        Matcher m = p.matcher(text);
        return m.matches();
    }
}
