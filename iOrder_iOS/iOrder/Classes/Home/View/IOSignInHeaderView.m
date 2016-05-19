//
//  IOSignInHeaderView.m
//  iOrder
//
//  Created by Tory on 16/5/18.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOSignInHeaderView.h"

@interface IOSignInHeaderView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *promptLabel;

@end

@implementation IOSignInHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupAllChildView];
    }
    return self;
}

- (void)setupAllChildView {
    UIImageView *iconView = [[UIImageView alloc] init];
    
}

@end
