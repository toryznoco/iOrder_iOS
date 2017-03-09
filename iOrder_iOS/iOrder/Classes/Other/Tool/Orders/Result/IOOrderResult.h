//
//  IOOrderResult.h
//  iOrder
//
//  Created by Tory on 16/5/28.
//  Copyright © 2016年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOOrderResult : NSObject

/**
 *  用户的订单数组(IOOrders)
 */
@property (strong, nonatomic) NSArray *orders;

@end
