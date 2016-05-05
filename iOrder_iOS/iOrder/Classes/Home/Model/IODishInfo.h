//
//  IODishInfo.h
//  iOrder
//
//  Created by 易无解 on 4/29/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

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
