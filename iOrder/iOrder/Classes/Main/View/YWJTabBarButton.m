//
//  YWJTabBarButton.m
//  iOrder
//
//  Created by 易无解 on 4/4/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJTabBarButton.h"

#import "YWJBadgeView.h"

#define kYWJImageRidio 0.7

@interface YWJTabBarButton ()

@property (nonatomic, weak) YWJBadgeView *badgeView;

@end

@implementation YWJTabBarButton

- (YWJBadgeView *)badgeView{
    if (!_badgeView) {
        YWJBadgeView *btn = [YWJBadgeView buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:btn];
        
        _badgeView = btn;
    }
    return _badgeView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

// 传递UITabBarItem给tabBarButton,给tabBarButton内容赋值
- (void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

// 只要监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateSelected];
    
    // 设置badgeValue
    self.badgeView.badgeValue = _item.badgeValue;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    1.imageView
    CGFloat imageW = self.width;
    CGFloat imageH = self.height * kYWJImageRidio;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
//    2.title
    CGFloat titleW = self.width;
    CGFloat titleH = self.height - imageH;
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
//    3.badgeView
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{
}

@end
