//
//  IOInputTextField.m
//  iOrder
//
//  Created by 易无解 on 22/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOInputTextField.h"

@implementation IOInputTextField

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 17, 0)];//设置文字距左边框的位置
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {//控制placeholder的位置
    return CGRectMake(17, 0, 270, 44);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {//控制光标的位置
    return CGRectMake(17, 0, 270, 44);
}

@end
