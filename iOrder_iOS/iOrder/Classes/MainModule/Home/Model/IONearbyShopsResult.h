//
//  IONearbyShopsResult.h
//  iOrder
//
//  Created by Tory on 30/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseResult.h"
@class IOShop;
@interface IONearbyShopsResult : IOHTTPBaseResult

/** 附近的店铺 */
@property (nonatomic, strong) NSArray<IOShop *> *nearShops;

@end
