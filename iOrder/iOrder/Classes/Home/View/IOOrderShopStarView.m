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

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIImageView *star = _stars[0];
    CGFloat starX = 0;
    CGFloat starY = 0;
    CGFloat starW = star.width;
    CGFloat starH = star.height;
    NSInteger i = 0;
    for (UIImageView *imageV in _stars) {
        starX = i * starW;
        imageV.frame = CGRectMake(starX, starY, starW, starH);
        i++;
    }
    
    self.width = i * starW;
    self.height = starH;
}

#pragma mark - public

- (void)setStartCount:(NSString *)startCount{
    _startCount = startCount;
    
    [self setupAllChildView];
}

#pragma mark - custom methods

- (void)setupAllChildView{
    for (int i = 0; i < 5; i++) {
        UIImageView *star = [[UIImageView alloc] init];
        if (i < [_startCount intValue]) {
            [star setImage:[UIImage imageNamed:@"helighted"]];
            [star sizeToFit];
            [self addSubview:star];
        }else{
            [star setImage:[UIImage imageNamed:@"normal"]];
            [star sizeToFit];
            [self addSubview:star];
        }
        [_stars addObject:star];
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
