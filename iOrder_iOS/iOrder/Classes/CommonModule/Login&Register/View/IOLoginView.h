//
//  IOLoginView.h
//  iOrder
//
//  Created by 易无解 on 8/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IOLoginView;

@protocol IOLoginViewDelegate <NSObject>

- (void)loginView:(IOLoginView *)loginView registerBtnDidPressed:(UIButton *)registerBtn;
- (void)loginView:(IOLoginView *)loginView loginBtnDidPressed:(UIButton *)loginBtn;

@end

#pragma mark - interface IOLoginView

@interface IOLoginView : UIView

@property (nonatomic, weak) id<IOLoginViewDelegate> delegate;

@end

#pragma mark - interface IOLoginTextField

@interface IOLoginTextField : UITextField

@end
