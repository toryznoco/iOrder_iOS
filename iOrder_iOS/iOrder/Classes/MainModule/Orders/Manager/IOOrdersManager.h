//
//  IOOrdersManager.h
//  iOrder
//
//  Created by Tory on 24/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IOOrder;

@interface IOOrdersManager : NSObject

+ (void)loadNewOrdersSuccess:(void (^)(NSArray<IOOrder *> * _Nullable orders))success
                         failure:(void (^)(NSError * _Nonnull error))failure;

@end
