//
//  IONavigationController.h
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IONavigationController;

@protocol IONavigationControllerDelegate <NSObject>

@optional
- (void)navigationControllerWillDisappear:(IONavigationController *)navigationVc isHidden:(BOOL)hidden;

@end
@interface IONavigationController : UINavigationController

@property (nonatomic, weak) id<IONavigationControllerDelegate> navigationDelegate;

@end
