//
//  YWJRegisterParam.h
//  iOrder
//
//  Created by 易无解 on 22/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YWJRegisterParam : NSObject<MJKeyValue>

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *password;

@end
