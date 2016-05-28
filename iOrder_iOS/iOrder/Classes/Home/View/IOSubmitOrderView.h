//
//  IOSubmitOrderView.h
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IOSubmitOrderView;

@protocol IOSubmitOrderViewDelegate <NSObject>

- (void)submitOrderView:(IOSubmitOrderView *)submitOrderView submitClicked:(UIButton *)btn;

@end

#pragma mark - interface IOSubmitOrderView

@interface IOSubmitOrderView : UIView

@property (nonatomic, copy) NSString *price;
@property (nonatomic, weak) id<IOSubmitOrderViewDelegate> delegate;

@end
