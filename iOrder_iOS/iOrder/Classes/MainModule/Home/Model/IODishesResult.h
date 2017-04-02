//
//  IODishesResult.h
//  iOrder
//
//  Created by 易无解 on 01/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseResult.h"
@class IODish;

@interface IODishesResult : IOHTTPBaseResult

/** 商品列表 */
@property (nonatomic, strong) NSArray<IODish *> *goods;

/** 店铺的商品分类列表 */
@property (nonatomic, strong) NSArray *categories;

@end
