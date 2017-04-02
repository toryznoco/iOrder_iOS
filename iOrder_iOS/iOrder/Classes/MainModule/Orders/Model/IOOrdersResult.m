//
//  IOOrdersResult.m
//  iOrder
//
//  Created by Tory on 02/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOOrdersResult.h"

@implementation IOOrdersResult

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"orders": @"IOOrder"
             };
}

@end
