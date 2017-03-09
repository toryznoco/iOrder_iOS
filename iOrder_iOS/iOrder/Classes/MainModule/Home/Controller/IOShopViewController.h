//
//  IOShopViewController.h
//  iOrder
//
//  Created by 易无解 on 4/25/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IOShop;

@interface IOShopViewController : UIViewController

@property (nonatomic, assign) int shopId;

@property (nonatomic, strong) IOShop *shopInfo;

@end
