//
//  IOBadgeButton.m
//  iOrder
//
//  Created by 易无解 on 5/6/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOBadgeButton.h"

@implementation IOBadgeButton

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        UIImage *image = [UIImage imageNamed:@"main_badge"];
        [self setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return self;
}

#pragma mark - public

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    if ([badgeValue integerValue] > 0) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        CGRect frame = self.frame;
        CGFloat badgeW = self.currentBackgroundImage.size.height;
        CGFloat badgeH = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            NSMutableDictionary *badgeAttr = [NSMutableDictionary dictionary];
            badgeAttr[NSFontAttributeName] = self.titleLabel.font;
            CGSize badgeSize = [badgeValue sizeWithAttributes:badgeAttr];
            badgeW = badgeSize.width + 5;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    }else{
        self.hidden = YES;
    }
}

@end
