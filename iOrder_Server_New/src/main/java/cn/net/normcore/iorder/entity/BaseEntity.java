package cn.net.normcore.iorder.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * 实体基类，定义了一些基本属性
 * Created by 81062 on 2017/3/15.
 */
@MappedSuperclass
@Inheritance(strategy = InheritanceType.JOINED)
public class BaseEntity {
    private Long id;  //主键
    private Date createTime;  //创建时间
    private Date updateTime;  //更新时间
    private Character path;  //0-已删除，1-正常

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", updatable = false)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "create_time", nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Column(name = "update_time")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Column(name = "path", nullable = false)
    public Character getPath() {
        return path;
    }

    public void setPath(Character path) {
        this.path = path;
    }
}
