package cn.net.normcore.iorder.api.app;

import cn.net.normcore.iorder.common.SimpleResult;
import org.springframework.stereotype.Controller;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.Map;

/**
 * Created by 81062 on 2017/3/16.
 */
@Controller
@Path("/app/customer")
@Produces(MediaType.APPLICATION_JSON)
public class CustomerApi {

    @GET
    public Map<String, Object> test() {
        return SimpleResult.optimistic("6666");
    }
}
