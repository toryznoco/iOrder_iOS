//
//  YWJShopsResult.h
//  iOrder
//
//  Created by 易无解 on 5/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YWJShopsResult : NSObject<MJKeyValue>

/**
 *  所有的商店数组(IOShops)
 */
@property (nonatomic, strong) NSArray *shops;

@end
