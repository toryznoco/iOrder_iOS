//
//  YWJSubmitOrderParam.h
//  iOrder
//
//  Created by 易无解 on 5/30/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJSubmitOrderParam : NSObject

/**
 用户id
 */
@property (nonatomic, assign) NSInteger userId;

/**
 商店id
 */
@property (nonatomic, assign) NSInteger shopId;

/**
 优惠券id
 */
@property (nonatomic, assign) NSInteger couponId;

@end
