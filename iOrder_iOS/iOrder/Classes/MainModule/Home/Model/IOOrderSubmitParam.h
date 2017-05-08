//
//  IOOrderSubmitParam.h
//  iOrder
//
//  Created by 易无解 on 07/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseParam.h"

@interface IOOrderSubmitParam : IOHTTPBaseParam

/** 店铺ID */
@property (nonatomic, assign) NSInteger shopId;

/** 使用的优惠券ID，默认值为空，表示未使用优惠券 */
@property (nonatomic, assign) NSInteger couponId;

@end
