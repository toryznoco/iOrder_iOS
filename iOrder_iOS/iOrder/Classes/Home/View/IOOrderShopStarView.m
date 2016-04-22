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

- (instancetype)init{
    if (self = [super init]) {
        _stars = [self stars];
        [self setupAllChildView];
    }
    return self;
}

#pragma mark - public

- (void)setStartCount:(NSString *)startCount{
    _startCount = startCount;
    
    [self setupData];
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
        [self addSubview:star];
        [_stars addObject:star];
        star.frame = CGRectMake(starX, starY, starW, starH);
    }
    
    self.width = 5 * starW;
    self.height = starH;
}

- (void)setupData{
    for (NSInteger i = 0; i < _stars.count; i++) {
        UIImageView *star = _stars[i];
        if (i < [_startCount intValue]) {
            [star setImage:[UIImage imageNamed:@"tabbar_home_selected"]];
        }else{
            [star setImage:[UIImage imageNamed:@"tabbar_home_normal"]];
        }
    }
}

@end
