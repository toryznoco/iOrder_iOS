//
//  IODishes.h
//  iOrder
//
//  Created by 易无解 on 5/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface IODishes : NSObject<MJKeyValue>

/**
 *  某个分类下的所有菜品列表
 */
@property (nonatomic, strong) NSArray *dishes;

/**
 *  该分类的名称
 */
@property (nonatomic, copy) NSString *catgName;

@end
