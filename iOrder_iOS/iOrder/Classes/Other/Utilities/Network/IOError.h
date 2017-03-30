//
//  IOError.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IOErrorCode){
    IOErrorCodeTokenFormatWrong = 4001,    //(@"提交的token格式错误，包括未提交token、token长度不是32位等") // 4001
    IOErrorCodeTokenInvalid,        //(@"提交的token无效或者已过期") // 4002
    IOErrorCodePhoneNumFormatWrong, //(@"手机号码格式错误") // 4003
    IOErrorCodeParamAbsent,         //(@"未提交必填数据时返回此错误") // 4004
    IOErrorCodePhneNumHaved,        //(@"手机号码已经注册") // 4005
    IOErrorCodeLoginFailed,         //(@"登陆失败，原因包括账号不存在，密码错误等") // 4006
    IOErrorCodeAccessTokenLimited,  //(@"获取token过于频繁，即在刷新token间隔时间限制内再次刷新token。目前设置的间隔时间限制为29分钟，即29分钟内同一客户端（IP）只能刷新1次") // 4007
    IOErrorCodeSignInAgain,         //(@"重复签到，调用店铺签到接口时，如果当日已经签过到，此时返回此错误") // 4008
    IOErrorCodeParamWrong,          //(@"参数不正确，但提交的参数值不合适的时候返回此错误") // 4009
    IOErrorCodeOrderStatusWrong,    //(@"订单状态错误，当调用更改订单状态的接口时，如果订单状态异常，此时返回此错误") // 4010
    IOErrorCodeTooQuick,            //(@"调用接口过于频繁") // 4011
    IOErrorCodeProduceOrderFailed,  //(@"生成订单失败，原因有提交的店铺ID不正确、商品所属店铺与提交的店铺ID不对应等") // 4012
    IOErrorCodeRefreshTokenWrong,   //(@"Refresh Token验证失败") // 4013
    IOErrorCodeUnknownFault,        //(@"系统内部错误，暂不确定原因的错误") // 5000
    IOErrorCodeCommon = 14700,
    IOErrorCodeServerDisable,
    IOErrorCodeNetworkDisable
};

@interface IOError : NSError

+ (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description;

@end
