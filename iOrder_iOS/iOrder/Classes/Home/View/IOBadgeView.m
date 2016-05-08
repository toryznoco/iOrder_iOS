//
//  IOBadgeView.m
//  iOrder
//
//  Created by 易无解 on 5/8/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOBadgeView.h"

#define kBadgeViewFont [UIFont systemFontOfSize:11]

@implementation IOBadgeView

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        self.titleLabel.font = kBadgeViewFont;
        [self sizeToFit];
    }
    return self;
}

#pragma mark - public

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
        return;
    }else{
        self.hidden = NO;
    }
    
    NSMutableDictionary *badgeAtt = [NSMutableDictionary dictionary];
    badgeAtt[NSFontAttributeName] = kBadgeViewFont;
    CGSize size = [badgeValue sizeWithAttributes:badgeAtt];
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
