//
//  IODishInfo.h
//  iOrder
//
//  Created by 易无解 on 4/29/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"


#pragma mark - interface IODishInfo
@interface IODishInfo : NSObject<MJKeyValue>

/**
 *  所有的菜
 */
@property (nonatomic, strong) NSArray *dishs;

/**
 *  菜的类别
 */
@property (nonatomic, copy) NSString *category;

@end


#pragma mark - interface IODish
@interface IODish : NSObject<MJKeyValue>

/**
 *  菜品ID，唯一标识,
 */
@property (nonatomic, assign) NSInteger goodsId;

/**
 *  菜品名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  商品原价
 */
@property (nonatomic, assign) CGFloat originalPrice;

/**
 *  商品现价
 */
@property (nonatomic, assign) CGFloat nowPrice;

/**
 *  商品图片url，不包含图片服务器根地址，需自行拼接
 */
@property (nonatomic, copy) NSString *picture;

/**
 *  评论数量
 */
@property (nonatomic, assign) NSInteger commentAmount;

/**
 *  当月销售数量
 */
@property (nonatomic, assign) NSInteger monthSale;

/**
 *  商品获得点赞数量
 */
@property (nonatomic, assign) NSInteger praiseAmount;

/**
 *  广告语
 */
@property (nonatomic, assign) NSInteger adInfo;

@end



#pragma mark - interface IODishes
@interface IODishes : NSObject<MJKeyValue>

/**
 *  商品分类ID
 */
@property (nonatomic, strong) NSArray *dishes;

/**
 *  该分类的名称
 */
@property (nonatomic, copy) NSString *catgName;


@end

@interface IODishCategory : NSObject<MJKeyValue>

/**
 *  商品分类ID
 */
@property (nonatomic, assign) NSInteger *categoryId;

/**
 *  分类名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  描述信息
 */
@property (nonatomic, copy) NSString *desc;

/**
 *  该分类下的商品列表
 */
@property (nonatomic, strong) NSArray *goodsList;

@end
