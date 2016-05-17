//
//  IOHomeShopView.h
//  iOrder
//
//  Created by 易无解 on 5/13/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - interface IOHomeShopHeaderView
@class IOShop;

@interface IOHomeShopHeaderView : UIView

@property (nonatomic, strong) IOShop *shopInfo;

@end


#pragma mark - interface IOHomeShopInfoView
@interface IOHomeShopInfoView : UIView

@property (nonatomic, strong) IOShop *shopInfo;

@end


#pragma mark - interface IOHomeShopOptionView
@interface IOHomeShopOptionView : UIView

@end