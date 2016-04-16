//
//  YWJVersionTool.h
//  iOrder
//
//  Created by 易无解 on 4/11/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJVersionTool : NSObject

+ (void)saveVersion:(NSString *)version;

+ (NSString *)currentVersion;

@end
