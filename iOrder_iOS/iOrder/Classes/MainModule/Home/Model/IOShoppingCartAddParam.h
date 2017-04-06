//
//  IOShoppingCartAddParam.h
//  iOrder
//
//  Created by 易无解 on 06/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseParam.h"

@interface IOShoppingCartAddParam : IOHTTPBaseParam<MJKeyValue>

/** 商品ID */
@property (nonatomic, assign) NSInteger goodsId;

/** 数量，默认值1 */
@property (nonatomic, assign) NSInteger amount;

@end
