//
//  IOUserInfo.h
//  iOrder
//
//  Created by 易无解 on 5/24/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOUserInfo : NSObject

/**
 用户头像名
 */
@property (nonatomic, copy) NSString *userIcon;

/**
 用户名称
 */
@property (nonatomic, copy) NSString *userName;

/**
 用户钱包
 */
@property (nonatomic, assign) NSInteger wallet;

/**
 用户红包数
 */
@property (nonatomic, assign) NSInteger redPacket;

/**
 用户证券数
 */
@property (nonatomic, assign) NSInteger voucher;

@end
