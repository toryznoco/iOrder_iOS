package cn.net.normcore.iorder.test;

import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.common.utils.InfoUtils;
import cn.net.normcore.iorder.common.utils.UuidUtils;
import org.junit.Test;

import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by 81062 on 2017/3/16.
 */
public class SimpleTest {

    @Test
    public void dateTest() {
        Calendar c = Calendar.getInstance();
        System.out.println(c.get(Calendar.YEAR));
        System.out.println(c.get(Calendar.MONTH));
        System.out.println(c.get(Calendar.DAY_OF_MONTH));

        c.set(Calendar.YEAR, 2017);
        c.set(Calendar.MONTH, 3 - 1);
        c.set(Calendar.DAY_OF_MONTH, 1);
        Date monthFirstDay = c.getTime();
        System.out.println(monthFirstDay);
        c.add(Calendar.MONTH, 1);
        c.set(Calendar.DAY_OF_MONTH, 0);
        Date monthLastDay = c.getTime();
        System.out.println(monthLastDay);
    }

    @Test
    public void uuidTest() {
        String uuid = UuidUtils.simpleUuid();
        System.out.println(uuid);
        System.out.println(uuid.length());
        for (int i = 0; i < 6; i ++) {
            System.out.println(InfoUtils.getMd5Salt());
        }
    }

    @Test
    public void arrayTest() {
        String[] array = new String[]{"123", "456"};
        System.out.println(array.toString());
    }

    @Test
    public void regularTest() {
        String url = "/123/app/login";
        String regExp = "^/app/*";
        Pattern pattern = Pattern.compile(regExp);
        Matcher matcher = pattern.matcher(url);
        if (matcher.find()) {
            System.out.println(true);
        }
    }

    @Test
    public void configTest() {
        System.out.println(Config.getProperty("token_key"));
        System.out.println(Config.getProperty("xx"));
    }
}
