//
//  IOOrdersResult.h
//  iOrder
//
//  Created by Tory on 02/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseResult.h"
#import "IOOrder.h"

@interface IOOrdersResult : IOHTTPBaseResult

/** 订单列表 */
@property (nonatomic, strong) NSArray<IOOrder *> *orders;

@end
