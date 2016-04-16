//
//  YWJBadgeView.m
//  iOrder
//
//  Created by 易无解 on 4/4/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJBadgeView.h"

#define YWJBadgeViewFont [UIFont systemFontOfSize:11]

@implementation YWJBadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        // 设置字体大小
        self.titleLabel.font = YWJBadgeViewFont;
        
        [self sizeToFit];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
        return;
    }else{
        self.hidden = NO;
    }
    
    NSMutableDictionary *badgeAttr = [NSMutableDictionary dictionary];
    badgeAttr[NSFontAttributeName] = YWJBadgeViewFont;
    CGSize size = [badgeValue sizeWithAttributes:badgeAttr];
    
    if (size.width > self.width) {// 文字的尺寸大于控件的宽度
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

@end
