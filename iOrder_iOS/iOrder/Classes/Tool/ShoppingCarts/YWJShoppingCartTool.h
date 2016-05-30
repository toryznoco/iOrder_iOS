//
//  YWJShoppingCartTool.h
//  iOrder
//
//  Created by 易无解 on 5/29/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJShoppingCartTool : NSObject

+ (void)addDishToShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void(^)())success failure:(void(^)(NSError *error))failure;

+ (void)removeDishFromShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
