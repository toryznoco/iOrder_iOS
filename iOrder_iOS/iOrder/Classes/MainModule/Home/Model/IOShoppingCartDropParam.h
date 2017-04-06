//
//  IOShoppingCartDropParam.h
//  iOrder
//
//  Created by 易无解 on 06/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseParam.h"

@interface IOShoppingCartDropParam : IOHTTPBaseParam<MJKeyValue>

/** 商品ID */
@property (nonatomic, assign) NSInteger goodsId;

/** 需要减少的数量，如果不提交此参数则直接删除购物车项 */
@property (nonatomic, assign) NSInteger amount;

@end
