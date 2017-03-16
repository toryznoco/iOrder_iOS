package cn.net.normcore.iorder.test;

import cn.net.normcore.iorder.common.utils.Config;
import org.junit.Test;

/**
 * Created by 81062 on 2017/3/16.
 */
public class SimpleTest {

    @Test
    public void configTest() {
        System.out.println(Config.getProperty("token_key"));
        System.out.println(Config.getProperty("xx"));
    }
}
