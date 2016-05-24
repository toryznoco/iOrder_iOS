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

@property (nonatomic, strong) IOUserInfo *userInfo;

@end


#pragma mark - interface IOAssetsView
@interface IOAssetsView : UIView

@property (nonatomic, strong) IOUserInfo *userInfo;

@end


#pragma mark - interface IOUserInfoView
@interface IOUserInfoView : UIView

@property (nonatomic, strong) IOUserInfo *userInfo;

@end


#pragma mark - interface IOAssetView
@interface IOAssetView : UIView

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, copy) NSString *assetName;

@end