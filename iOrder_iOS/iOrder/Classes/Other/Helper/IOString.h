//
//  IOString.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#ifndef IOString_h
#define IOString_h

/*************************************************************************************
 Key
 *************************************************************************************/
#define kVersionKey @"version"
#define kPictureServerPath @"http://normcore.net.cn/fileServ/picture/"
#define kIOHTTPBaseUrl @"https://iorder.normcore.net.cn/api/"

#define kIOAccessTokenKey @"accessToken"
#define kIOAccessTokenExpiredTimeKey @"accessTokenExpiredTime"
#define kIORefreshTokenKey @"refreshToken"
#define kIORefreshTokenExpiredTimeKey @"refreshTokenExpiredTime"

#define kIOStringNetworkDisable      (@"您的网络貌似不可用")
#define kIOStringServerException     (@"服务器异常，请稍后重试")
#define kIOStringTokenFormatWrong    (@"提交的token格式错误，包括未提交token、token长度不是32位等") // 4001
#define kIOStringTokenInvalid        (@"提交的token无效或者已过期") // 4002
#define kIOStringPhoneNumFormatWrong (@"手机号码格式错误") // 4003
#define kIOStringParamAbsent         (@"未提交必填数据时返回此错误") // 4004
#define kIOStringPhneNumHaved        (@"手机号码已经注册") // 4005
#define kIOStringLoginFailed         (@"登陆失败，原因包括账号不存在，密码错误等") // 4006
#define kIOStringAccessTokenLimited  (@"获取token过于频繁，即在刷新token间隔时间限制内再次刷新token。目前设置的间隔时间限制为29分钟，即29分钟内同一客户端（IP）只能刷新1次") // 4007
#define kIOStringSignInAgain         (@"重复签到，调用店铺签到接口时，如果当日已经签过到，此时返回此错误") // 4008
#define kIOStringParamWrong          (@"参数不正确，但提交的参数值不合适的时候返回此错误") // 4009
#define kIOStringOrderStatusWrong    (@"订单状态错误，当调用更改订单状态的接口时，如果订单状态异常，此时返回此错误") // 4010
#define kIOStringTooQuick            (@"调用接口过于频繁") // 4011
#define kIOStringProduceOrderFailed  (@"生成订单失败，原因有提交的店铺ID不正确、商品所属店铺与提交的店铺ID不对应等") // 4012
#define kIOStringRefreshTokenWrong   (@"Refresh Token验证失败") // 4013
#define kIOStringUnknownFault        (@"系统内部错误，暂不确定原因的错误") // 5000


#endif /* IOString_h */
