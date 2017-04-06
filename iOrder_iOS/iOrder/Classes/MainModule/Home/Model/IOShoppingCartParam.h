//
//  IOShoppingCartParam.h
//  iOrder
//
//  Created by 易无解 on 05/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseParam.h"

@interface IOShoppingCartParam : IOHTTPBaseParam<MJKeyValue>

/**
 *  商铺ID，唯一标识
 */
@property (nonatomic, assign) NSInteger shopId;

@end
