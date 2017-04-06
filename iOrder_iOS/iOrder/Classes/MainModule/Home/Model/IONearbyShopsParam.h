//
//  IONearbyShopsParam.h
//  iOrder
//
//  Created by Tory on 30/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseParam.h"

@interface IONearbyShopsParam : IOHTTPBaseParam<MJKeyValue>

/** 经度 */
@property (nonatomic, assign) double lng;

/** 纬度 */
@property (nonatomic, assign) double lat;

/** 页号，从1开始，默认值1 */
@property (nonatomic, assign) NSInteger pageNum;

/** 每页数量，默认值10 */
@property (nonatomic, assign) NSInteger pageSize;

@end
