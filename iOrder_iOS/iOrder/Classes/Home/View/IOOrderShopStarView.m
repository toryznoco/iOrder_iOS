//
//  IOOrderShopStarView.m
//  iOrder
//
//  Created by 易无解 on 4/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOOrderShopStarView.h"

@interface IOOrderShopStarView ()

@end

@implementation IOOrderShopStarView

#pragma mark - privacy

#pragma mark - public

- (void)setStartCount:(NSString *)startCount{
    _startCount = startCount;
    
    [self setupAllChildView];
}

#pragma mark - custom methods

- (void)setupAllChildView{
    CGFloat starX = 0;
    CGFloat starY = 0;
    CGFloat starW = 16;
    CGFloat starH = 16;
    for (NSInteger i = 0; i < 5; i++) {
        starX = i * starW;
        UIImageView *star = [[UIImageView alloc] init];
        if (i < [_startCount intValue]) {
            [star setImage:[UIImage imageNamed:@"tabbar_home_selected"]];
            [self addSubview:star];
        }else{
            [star setImage:[UIImage imageNamed:@"tabbar_home_normal"]];
            [self addSubview:star];
        }
        star.frame = CGRectMake(starX, starY, starW, starH);
    }
    self.width = 5 * starW;
    self.height = starH;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
