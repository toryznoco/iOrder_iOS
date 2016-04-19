//
//  YWJNewFeatureScrollPage.m
//  iOrder
//
//  Created by 易无解 on 4/12/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJNewFeatureScrollPage.h"

#define kImageCount 4

@interface YWJNewFeatureScrollPage ()

@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation YWJNewFeatureScrollPage

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentOffset = CGPointZero;
        self.contentSize = CGSizeMake(kImageCount * self.frame.size.width, self.frame.size.height);
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addChildView];
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat imageVW = self.width;
    CGFloat imageVH = self.height;
    CGFloat imageVX = 0;
    CGFloat imageVY = 0;
    NSInteger i = 0;
    for (UIImageView *imageV in self.imageViews) {
        imageVX = i * imageVW;
        imageV.frame = CGRectMake(imageVX, imageVY, imageVW, imageVH);
        i++;
    }
}

#pragma mark - Custom methods

- (void)addChildView{
    for (int i = 0; i < kImageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self.imageViews addObject:imageView];
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
