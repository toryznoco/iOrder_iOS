//
//  YWJLoginResult.h
//  iOrder
//
//  Created by 易无解 on 8/18/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IOUser.h"

@interface YWJLoginResult : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) IOUser *user;

@end
