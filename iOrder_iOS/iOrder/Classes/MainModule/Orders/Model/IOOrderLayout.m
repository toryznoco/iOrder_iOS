//
//  IOOrderLayout.m
//  iOrder
//
//  Created by Tory on 31/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOOrderLayout.h"

@implementation IOOrderLayout

- (instancetype)initWithStatus:(IOOrder *)order {
    if (!order) return nil;
    self = [super init];
    _order = order;
    [self layout];
    return self;
}

- (void)layout {
    [self _layout];
}

- (void)_layout {
    _marginTop = kIOCellTopMargin;
    _titleHeight = 0;
    _infoHeight = 0;
    _barHeight = 0;
    _marginBottom = kIOCellBottomMargin;
    
    [self _layoutTitle];
    [self _layoutInfo];
    [self _layoutBar];
    
    // 计算高度
    _height = 0;
    _height += _marginTop;
    _height += _titleHeight;
    _height += _infoHeight;
    if (_barHeight > 0) {
        _height += _barHeight;
    }
    _height += _marginBottom;
}

- (void)_layoutTitle {
    _titleHeight = kIOCellTitleHeight;
}

- (void)_layoutInfo {
    _infoHeight = kIOCellInfoHeight;
}

- (void)_layoutBar {
    if (_order.status == IOOrderStatusCancel || _order.status == IOOrderStatusDone) {
        _barHeight = 0;
    } else {
        _barHeight = kIOCellBarHeight;
    }
}
@end
