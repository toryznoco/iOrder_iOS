package cn.net.normcore.iorder.vo.goods;

import cn.net.normcore.iorder.entity.goods.GoodsCategory;
import cn.net.normcore.iorder.vo.BaseVo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 81062 on 2017/3/18.
 */
public class GoodsCategoryVo extends BaseVo {
    private String name;  //分类名称
    private String description;  //备注信息
    private List<GoodsVo> goodsList;  //分类下的商品列表

    public static List<GoodsCategoryVo> listFromCategories(List<GoodsCategory> categories) {
        List<GoodsCategoryVo> categoryVos = new ArrayList<>();
        categories.forEach(category -> categoryVos.add(fromCategory(category)));
        return categoryVos;
    }

    public static GoodsCategoryVo fromCategory(GoodsCategory category) {
        GoodsCategoryVo categoryVo = new GoodsCategoryVo();
        categoryVo.setId(category.getId());
        categoryVo.setName(category.getName());
        categoryVo.setDescription(category.getDescription());
        categoryVo.setGoodsList(GoodsVo.listFromGoods(category.getGoods()));
        return categoryVo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<GoodsVo> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<GoodsVo> goodsList) {
        this.goodsList = goodsList;
    }
}
