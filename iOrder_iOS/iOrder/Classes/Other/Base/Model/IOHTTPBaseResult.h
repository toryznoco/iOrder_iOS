//
//  IOHTTPBaseResult.h
//  iOrder
//
//  Created by Tory on 27/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOHTTPBaseResult : NSObject

/**
 当请求结果为正常业务期望返回值时取值为YES，否则为NO
 */
@property (nonatomic, assign) BOOL result;

/**
 当请求结果为正常业务期望返回值时取值为2000，否则为错误码
 4001：提交的token格式错误，包括未提交token、token长度不是32位等；
 4002：提交的token无效或者已过期；
 4003：手机号码格式错误；
 4004：未提交必填数据时返回此错误；
 4005：手机号码已经注册；
 4006：登陆失败，原因包括账号不存在，密码错误等；
 4007：获取token过于频繁，即在刷新token间隔时间限制内再次刷新token。目前设置的间隔时间限制为29分钟，即29分钟内同一客户端（IP）只能刷新1次；
 4008：重复签到，调用店铺签到接口时，如果当日已经签过到，此时返回此错误；
 4009：参数不正确，但提交的参数值不合适的时候返回此错误；
 4010：订单状态错误，当调用更改订单状态的接口时，如果订单状态异常，此时返回此错误；
 4011：重复登陆；
 4012：生成订单失败，原因有提交的店铺ID不正确、商品所属店铺与提交的店铺ID不对应等；
 5000：系统内部错误，暂不确定原因的错误；
 */
@property (nonatomic, assign) double code;

/**
 请求结果说明信息
 */
@property (nonatomic, strong) NSString *message;

@end
