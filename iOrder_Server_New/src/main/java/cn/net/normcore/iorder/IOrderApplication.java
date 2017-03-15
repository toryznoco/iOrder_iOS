package cn.net.normcore.iorder;

import org.glassfish.jersey.logging.LoggingFeature;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.ServerProperties;
import org.glassfish.jersey.server.TracingConfig;

/**
 * Jersey配置类
 * Created by 81062 on 2017/3/15.
 */
public class IOrderApplication extends ResourceConfig {

    public IOrderApplication() {
        packages("cn.net.normcore.iorder.api");
        register(LoggingFeature.class);
        property(ServerProperties.TRACING, TracingConfig.ON_DEMAND.name());
    }
}
