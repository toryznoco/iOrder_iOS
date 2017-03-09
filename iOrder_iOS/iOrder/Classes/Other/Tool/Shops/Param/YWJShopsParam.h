//
//  YWJShopsParam.h
//  iOrder
//
//  Created by 易无解 on 5/9/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJShopsParam : NSObject

/**
 *  从第几个开始获取，第一个为0
 */
@property (nonatomic, assign) int startId;

/**
 *  要获取商铺数量
 */
@property (nonatomic, assign) int amount;

/**
 *  定位经度，需要精确到小数点后6位
 */
@property (nonatomic, assign) double userLng;

/**
 *  定位纬度，需要精确到小数点后6位
 */
@property (nonatomic, assign) double userLat;

@end
