//
//  IOShopView.h
//  iOrder
//
//  Created by 易无解 on 5/13/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - interface IOShopHeaderView
@class IOShop;

@interface IOShopHeaderView : UIView

@property (nonatomic, strong) IOShop *shopInfo;

@end


#pragma mark - interface IOShopInfoView
@interface IOShopInfoView : UIView

@property (nonatomic, strong) IOShop *shopInfo;

@end
