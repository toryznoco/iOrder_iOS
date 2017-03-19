package cn.net.normcore.iorder.repository.business;

import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.repository.BaseRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by 81062 on 2017/3/18.
 */
public interface ShopRepository extends BaseRepository<Shop, Long> {

    /**
     * 原生SQL查询店铺列表，按距离升序排列
     *
     * @param lng        定位经度
     * @param lat        定位纬度
     * @param beginIndex 开始下表
     * @param count      数量限制
     * @return 数组保存的列值
     */
    @Query(value = "SELECT shop.*, getDistance(:lng, :lat, coord_y, coord_x) as distance FROM shop ORDER BY distance LIMIT :beginIndex, :count", nativeQuery = true)
    List<Object[]> findNear(@Param("lng") Double lng, @Param("lat") Double lat, @Param("beginIndex") int beginIndex, @Param("count") int count);
}
