//
//  IOUserInfo.h
//  iOrder
//
//  Created by 易无解 on 5/24/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOUserInfo : NSObject

@property (nonatomic, copy) NSString *userIcon;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger wallet;

@property (nonatomic, assign) NSInteger redPacket;

@property (nonatomic, assign) NSInteger voucher;

@end
