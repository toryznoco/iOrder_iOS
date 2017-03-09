//
//  IOSegmentScrollView.h
//  iOrder
//
//  Created by 易无解 on 7/14/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - interface IOSegmentScrollView

@interface IOSegmentScrollView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray contentViewArray:(NSArray *)contentViewArray;

@end


#pragma mark - interface IOSegmentScrollView
typedef void(^btnClickBlock)(NSInteger index);

@interface IOSegmentView : UIView

/**
 *  未选中时的文字颜色,默认黑色
 */
@property (nonatomic,strong) UIColor *titleNomalColor;

/**
 *  选中时的文字颜色,默认红色
 */
@property (nonatomic,strong) UIColor *titleSelectColor;

/**
 *  字体大小，默认15
 */
@property (nonatomic,strong) UIFont  *titleFont;

/**
 *  默认选中的index=1，即第一个
 */
@property (nonatomic,assign) NSInteger defaultIndex;

/**
 *  点击后的block
 */
@property (nonatomic,copy)btnClickBlock block;

/**
 *  初始化方法
 *
 *  @param frame      frame
 *  @param titleArray 传入数组
 *  @param block      点击后的回调
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block;

@end
