package cn.net.normcore.iorder.api.app;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.filter.ValidateToken;
import cn.net.normcore.iorder.service.promotion.PromotionService;
import cn.net.normcore.iorder.vo.promotion.PromotionVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.Map;

/**
 * 推广信息相关接口
 * Created by 81062 on 2017/3/19.
 */
@Controller
@Path("/app/promotion")
@Produces(MediaType.APPLICATION_JSON)
@ValidateToken
public class PromotionApi {
    @Autowired
    private PromotionService promotionService;

    /**
     * 获取所有推广信息
     *
     * @return
     */
    @GET
    public Map<String, Object> promotion() {
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("promotions", PromotionVo.listFromPromotions(promotionService.findAll()));
        return result;
    }
}
