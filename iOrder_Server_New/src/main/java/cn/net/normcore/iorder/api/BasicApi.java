package cn.net.normcore.iorder.api;

import cn.net.normcore.iorder.common.SimpleResult;
import org.springframework.stereotype.Controller;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.Map;

/**
 * Created by 81062 on 2017/3/21.
 */
@Controller
@Path("/basic")
@Produces(MediaType.APPLICATION_JSON)
public class BasicApi {

    /**
     * 提交的TOKEN格式不正确时跳转到此API
     * 1、TOKEN为空
     * 2、TOKEN长度不为32
     *
     * @return
     */
    @GET
    @Path("/token/error")
    public Map<String, Object> tokenError() {
        return SimpleResult.pessimistic(4001, "TOKEN格式错误");
    }

    /**
     * 提交的TOKEN验证失败时跳转到此API
     * 1、TOKEN无效
     * 2、TOKEN已过期
     *
     * @return
     */
    @GET
    @Path("/token/invalid")
    public Map<String, Object> tokenInvalid() {
        return SimpleResult.pessimistic(4002, "TOKEN无效");
    }
}
