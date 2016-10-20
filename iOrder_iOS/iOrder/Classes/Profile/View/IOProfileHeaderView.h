//
//  IOProfileHeaderView.h
//  iOrder
//
//  Created by Tory on 16/5/13.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IOUserInfo;

#pragma mark - interface IOProfileHeaderView
@interface IOProfileHeaderView : UIView

/**
 保存用户信息模型
 */
@property (nonatomic, strong) IOUserInfo *userInfo;

@end


#pragma mark - interface IOAssetsView
@interface IOAssetsView : UIView

/**
 保存用户信息模型
 */
@property (nonatomic, strong) IOUserInfo *userInfo;

@end


#pragma mark - interface IOUserInfoView
@interface IOUserInfoView : UIView

/**
 保存用户信息模型
 */
@property (nonatomic, strong) IOUserInfo *userInfo;

@end


#pragma mark - interface IOAssetView
@interface IOAssetView : UIView

/**
 数量
 */
@property (nonatomic, assign) NSInteger count;

/**
 单元
 */
@property (nonatomic, copy) NSString *unit;

/**
 图片名
 */
@property (nonatomic, copy) NSString *iconName;

/**
 资产名
 */
@property (nonatomic, copy) NSString *assetName;

@end
