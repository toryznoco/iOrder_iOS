//
//  UIBarButtonItem+IOBarButtonItem.h
//  iOrder
//
//  Created by 易无解 on 5/13/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (IOBarButtonItem)

/**
 *根据图片快速创建一个UIBarButtonItem，自定义大小
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;

+ (UIBarButtonItem *)initWithtitleColor:(UIColor *)titleColor target:(id)target action:(SEL)action title:(NSString *)title;

@end
