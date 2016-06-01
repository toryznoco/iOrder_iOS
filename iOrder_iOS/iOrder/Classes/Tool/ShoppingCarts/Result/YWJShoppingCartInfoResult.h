//
//  YWJShoppingCartInfoResult.h
//  iOrder
//
//  Created by 易无解 on 6/1/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface YWJShoppingCartInfoResult : NSObject<MJKeyValue>

/**
 *  总金额，两位小数
 */
@property (nonatomic, assign) CGFloat totalPri;
/**
 *  数组
 */
@property (nonatomic, strong) NSMutableArray *itmes;

@end
