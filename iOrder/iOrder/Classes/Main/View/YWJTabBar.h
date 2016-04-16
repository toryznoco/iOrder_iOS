//
//  YWJTabBar.h
//  iOrder
//
//  Created by 易无解 on 4/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//  UITabBar 里的内容

#import <UIKit/UIKit.h>

@class YWJTabBar;

@protocol YWJTabBarDelegate <NSObject>

@optional
- (void)tabBar:(YWJTabBar *)tabBar didClickButton:(NSUInteger)index;

@end

@interface YWJTabBar : UIView

/**
 *  items:保存每一个按钮对应tabBarItem模型
 */
@property (nonatomic, strong) NSArray *items;

/**
 *  代理
 */
@property (nonatomic, weak) id<YWJTabBarDelegate> delegate;

@end
