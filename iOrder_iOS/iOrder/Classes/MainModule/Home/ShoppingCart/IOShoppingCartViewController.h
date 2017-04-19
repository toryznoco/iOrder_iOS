//
//  IOShoppingCartViewController.h
//  iOrder
//
//  Created by 易无解 on 13/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IOShoppingCartResult;

@class IOShoppingCartViewController, IOShoppingCartItem;

@protocol IOshoppingCartViewControllerDelegate <NSObject>

- (void)shoppingCartViewController:(IOShoppingCartViewController *)shoppingCartVc dishItem:(IOShoppingCartItem *)item clickedBtn:(UIButton *)btn;

@end

@interface IOShoppingCartViewController : UITableViewController

@property (nonatomic, strong) IOShoppingCartResult *shoppingCartInfo;

@property (nonatomic, weak) id<IOshoppingCartViewControllerDelegate> delegate;

@end
