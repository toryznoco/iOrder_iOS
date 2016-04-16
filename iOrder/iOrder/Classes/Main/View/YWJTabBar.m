//
//  YWJTabBar.m
//  iOrder
//
//  Created by 易无解 on 4/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJTabBar.h"

#import "YWJTabBarButton.h"

@interface YWJTabBar ()

/**
 *  保存所有添加的按钮，用于标记按钮
 */
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation YWJTabBar

#pragma mark - load View

- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

#pragma mark - self

- (void)setItems:(NSArray *)items{
    _items = items;
    
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in items) {
        YWJTabBarButton *btn = [YWJTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        
        //标记按钮
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        
        [self.buttons addObject:btn];
        [self addSubview:btn];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat tabBarW = self.width;
    CGFloat tabBarH = self.height;
    
    CGFloat btnW = tabBarW / (self.items.count);
    CGFloat btnH = tabBarH;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    NSUInteger i = 0;
    for (UIView *tabBarButton in self.buttons) {
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
}


#pragma mark - click event
- (void)btnClick:(UIButton *)button{
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
    
//    切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

@end
