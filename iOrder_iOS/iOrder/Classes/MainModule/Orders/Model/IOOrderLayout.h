//
//  IOOrderLayout.h
//  iOrder
//
//  Created by Tory on 31/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOOrder.h"

// 宽高
#define kIOCellTopMargin 8          // cell 顶部灰色留白
#define kIOCellPadding 12           // 内边距
#define kIOCellTitleHeight 25       // 标题栏高度
#define kIOCellInfoHeight 76        // info栏高度
#define kIOCellBarHeight 35         // cell 下方工具栏高度
#define kIOCellBottomMargin 2    // cell 下方灰色留白

// shopName
#define kIOCellShopNameMarginLeft 8
#define kIOCellShopNameWidth 200

// status
#define kIOCellStatusWidth 70
#define kIOCellStatusHeight 15
#define kIOCellStatusMarginRight 14

#define kIOCellIconMarginTop 8
#define kIOCellIconWidth 60

#define kIOCellOrderLabelMarginLeft 10
#define kIOCellOrderLabelWidth 70
#define kIOCellOrderLabelHeight 15

#define kIOCellOrderWidth 160

#define kIOCellOrderLabelMarginTop ((kIOCellIconWidth-3*kIOCellOrderLabelHeight)*0.5)

#define kIOCellButtonMarginTop 8
#define kIOCellButtonMarginRight 12
#define kIOCellButtonWidth 60

#pragma mark - font

#define kIOCellFont [UIFont systemFontOfSize:13]

#pragma mark - color

#define kIOLineColor [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.2]
#define kIOTextColor [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1]

/**
 一个 Cell 的布局。
 布局排版应该在后台线程完成。
 */
@interface IOOrderLayout : NSObject

- (instancetype)initWithStatus:(IOOrder *)order;
- (void)layout; ///< 计算布局

/** 数据 */
@property (nonatomic, strong) IOOrder *order;

/// 下面是布局结果

/** 顶部灰色留白 */
@property (nonatomic, assign) CGFloat marginTop;

/** 标题栏高度 */
@property (nonatomic, assign) CGFloat titleHeight;

/** 信息栏高度 */
@property (nonatomic, assign) CGFloat infoHeight;

/** 工具栏高度 */
@property (nonatomic, assign) CGFloat barHeight;

/** 下边留白 */
@property (nonatomic, assign) CGFloat marginBottom;

/** 总高度 */
@property (nonatomic, assign) CGFloat height;

@end
