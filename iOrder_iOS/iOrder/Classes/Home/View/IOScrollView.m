//
//  IOScrollView.m
//  iOrder
//
//  Created by 易无解 on 4/22/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOScrollView.h"

@interface IOScrollView ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;

@end

@implementation IOScrollView

#pragma mark - privacy

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
        backgroundView.frame = CGRectMake(0, 0, YWJKeyWindow.width, 160);
        [self addSubview:backgroundView];
        
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, YWJKeyWindow.width, 160) shouldInfiniteLoop:YES imageNamesGroup:nil];
        [self addSubview:cycleScrollView];
        _cycleScrollView = cycleScrollView;
        
        cycleScrollView.delegate = self;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        cycleScrollView.autoScrollTimeInterval = 4.0;
    }
    return self;
}

#pragma mark - public

- (void)setImages:(NSArray *)images{
    _images = images;
    
    _cycleScrollView.localizationImageNamesGroup = images;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    YWJLog(@"点击了某张图片");
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    YWJLog(@"滑动到第几张图片");
}

@end
