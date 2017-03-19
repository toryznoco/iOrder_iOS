package cn.net.normcore.iorder.vo.customer;

import cn.net.normcore.iorder.entity.customer.SignInRecord;
import cn.net.normcore.iorder.vo.BaseVo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public class SignInRecordVo extends BaseVo {
    private Date signInTime;  //签到时间
    private Date signInDate;  //签到日期，每天只能签到一次

    public static List<SignInRecordVo> listFromSignInRecords(List<SignInRecord> records) {
        List<SignInRecordVo> recordVos = new ArrayList<>();
        records.forEach(record -> recordVos.add(fromSignInRecord(record)));
        return recordVos;
    }

    public static SignInRecordVo fromSignInRecord(SignInRecord record) {
        SignInRecordVo recordVo = new SignInRecordVo();
        recordVo.setId(record.getId());
        recordVo.setSignInTime(record.getSignInTime());
        recordVo.setSignInDate(record.getSignInDate());
        return recordVo;
    }

    public Date getSignInTime() {
        return signInTime;
    }

    public void setSignInTime(Date signInTime) {
        this.signInTime = signInTime;
    }

    public Date getSignInDate() {
        return signInDate;
    }

    public void setSignInDate(Date signInDate) {
        this.signInDate = signInDate;
    }
}
