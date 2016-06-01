//
//  YWJSubmitOrderTool.h
//  iOrder
//
//  Created by 易无解 on 5/30/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJSubmitOrderTool : NSObject

+ (void)submitOrderWithUserId:(NSInteger)userId shopId:(NSInteger)shopId couponId:(NSInteger)couponId success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
