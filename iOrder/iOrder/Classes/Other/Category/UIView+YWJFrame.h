//
//  UIView+YWJFrame.h
//  iOrder
//
//  Created by 易无解 on 4/4/16.
//  Copyright © 2016 易无解. All rights reserved.
//  返回当前控件的frame相关的值

#import <UIKit/UIKit.h>

@interface UIView (YWJFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end
