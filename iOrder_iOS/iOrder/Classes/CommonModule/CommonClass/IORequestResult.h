//
//  IORequestResult.h
//  iOrder
//
//  Created by 易无解 on 22/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface IORequestResult : NSObject<MJKeyValue>

@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *message;

@end
