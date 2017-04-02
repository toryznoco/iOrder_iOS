//
//  IOConst.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#ifndef IOConst_h
#define IOConst_h

#pragma mark - 自定义日志输出
/**
 自定义日志输出
 */
#ifdef DEBUG // 调试
    #define IOLog(...) NSLog(__VA_ARGS__)
#else // 发布
    #define NSLog(...)
#endif

#pragma mark - 尺寸
/*************************************************************************************
 尺寸（Size）
 *************************************************************************************/
#define kIONavigationBarHeight 64
#define IOScreenWidth [UIScreen mainScreen].bounds.size.width
#define IOScreenHeight [UIScreen mainScreen].bounds.size.height

#pragma mark - 颜色
/*************************************************************************************
 颜色常量（Color）
 *************************************************************************************/
#define kIOThemeColor [UIColor orangeColor]
#define kIOBackgroundColor [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0]

#endif /* IOConst_h */
