//
//  IOOrderShopStarView.m
//  iOrder
//
//  Created by 易无解 on 4/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOOrderShopStarView.h"

@interface IOOrderShopStarView ()

@property (nonatomic, strong) NSMutableArray *stars;

@end

@implementation IOOrderShopStarView

#pragma mark - privacy

- (NSMutableArray *)stars{
    if (!_stars) {
        _stars = [NSMutableArray array];
    }
    return _stars;
}

#pragma mark - public

- (void)setStartCount:(NSString *)startCount{
    _startCount = startCount;
    
    _stars = [self stars];
    
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
        [_stars addObject:star];
    }
    self.width = _stars.count * starW;
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
