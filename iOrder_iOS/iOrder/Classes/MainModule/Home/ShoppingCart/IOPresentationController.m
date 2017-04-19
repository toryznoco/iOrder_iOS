//
//  IOPresentationController.m
//  iOrder
//
//  Created by 易无解 on 13/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOPresentationController.h"

@interface IOPresentationController ()

/** 蒙板 */
@property (nonatomic, weak) UIView *coverView;

@end

@implementation IOPresentationController

#pragma mark - 系统回调函数

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    
//    0.属性
    self.presentedView.frame = self.presentedFrame;
    
//    1.设置界面
    [self setupAllSubViews];
}

#pragma mark - 设置界面相关函数

- (void)setupAllSubViews {
//    1.蒙板
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    coverView.frame = self.containerView.bounds;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
    [coverView addGestureRecognizer:tapGes];
    [self.containerView insertSubview:coverView atIndex:0];
}

#pragma mark - 事件监听函数

- (void)coverViewClick {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 外部属性

- (void)setPresentedFrame:(CGRect)presentedFrame {
    _presentedFrame = presentedFrame;
}
@end
