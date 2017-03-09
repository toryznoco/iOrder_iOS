//
//  IOUser.h
//  iOrder
//
//  Created by 易无解 on 8/18/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOUser : NSObject

@property (nonatomic, assign) NSInteger userLevel;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) NSInteger userId;

@end
