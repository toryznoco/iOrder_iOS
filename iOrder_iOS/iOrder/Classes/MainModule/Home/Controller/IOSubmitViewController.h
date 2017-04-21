//
//  IOSubmitViewController.h
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IOSubmitViewController;

@protocol IOSubmitViewControllerDelegate <NSObject>

- (void)submitViewController:(IOSubmitViewController *)submitVc isPaySuccessful:(BOOL)suc;

@end

@class IOShop;

@interface IOSubmitViewController : UIViewController

@property (nonatomic, copy) NSString *totalPrice;
@property (nonatomic, strong) IOShop *shopInfo;
@property (nonatomic, weak) id<IOSubmitViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL *isRefresh;

@end
