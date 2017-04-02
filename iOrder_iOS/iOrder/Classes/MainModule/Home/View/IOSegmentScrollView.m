//
//  IOSegmentScrollView.m
//  iOrder
//
//  Created by 易无解 on 7/14/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOSegmentScrollView.h"

#pragma mark - implementation IOSegmentScrollView

@interface IOSegmentScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) IOSegmentView *segmentToolView;

@end

@implementation IOSegmentScrollView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray contentViewArray:(NSArray *)contentViewArray {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgScrollView];
        
        _segmentToolView = [[IOSegmentView alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, 44) titles:titleArray clickBlick:^(NSInteger index) {
            [_bgScrollView setContentOffset:CGPointMake(IOScreenWidth*(index - 1), 0)];
        }];
        [self addSubview:_segmentToolView];
        
        for (NSInteger i = 0; i < contentViewArray.count; i++) {
            UIView *contentView = contentViewArray[i];
            contentView.frame = CGRectMake(IOScreenWidth * i, _segmentToolView.bounds.size.height, IOScreenWidth, _bgScrollView.frame.size.height - _segmentToolView.bounds.size.height);
            [_bgScrollView addSubview:contentView];
        }
    }
    
    return self;
}

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentToolView.frame.size.height, IOScreenWidth, self.bounds.size.height-_segmentToolView.bounds.size.height)];
        _bgScrollView.contentSize = CGSizeMake(IOScreenWidth*3, self.bounds.size.height-_segmentToolView.bounds.size.height);
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.delegate = self;
        _bgScrollView.bounces = NO;
        _bgScrollView.pagingEnabled = YES;
    }
    
    return _bgScrollView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _bgScrollView) {
        NSInteger currentPage = _bgScrollView.contentOffset.x / IOScreenWidth;
        _segmentToolView.defaultIndex = currentPage + 1;
    }
}

@end


#pragma mark - implementation IOSegmentView

#define MAX_TitleNumInWindow 5

@interface IOSegmentView ()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIView *selectLine;
@property (nonatomic,assign) CGFloat btn_w;

@end

@implementation IOSegmentView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block {
    if (self = [super initWithFrame:frame]) {
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset= CGSizeMake(2, 2);
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.2;
        
        _btn_w = 0.0;
        if (titleArray.count < MAX_TitleNumInWindow + 1) {
            _btn_w = IOScreenWidth / titleArray.count;
        } else {
            _btn_w = IOScreenWidth / MAX_TitleNumInWindow;
        }
        
        _titles = titleArray;
        _defaultIndex = 1;
        _titleFont = [UIFont systemFontOfSize:15];
        _btns = [[NSMutableArray alloc] initWithCapacity:15];
        _titleNomalColor = IORGBColor(92, 91, 92, 1);
        _titleSelectColor = kIOThemeColor;
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, self.frame.size.height)];
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.contentSize = CGSizeMake(_btn_w * titleArray.count, self.frame.size.height);
        [self addSubview:_bgScrollView];
        
        _selectLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, _btn_w, 2)];
        _selectLine.backgroundColor = _titleSelectColor;
        [_bgScrollView addSubview:_selectLine];
        
        for (NSInteger i = 0; i < titleArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(_btn_w * i, 0, _btn_w, self.frame.size.height - 2);
            btn.tag = i + 1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.titleLabel.font = _titleFont;
            [_bgScrollView addSubview:btn];
            [_btns addObject:btn];
            if (i == 0) {
                _titleBtn = btn;
                btn.selected = YES;
            }
            
            self.block = block;
        }
    }
    
    return self;
}

- (void)btnClick:(UIButton *)btn {
    if (self.block) {
        self.block(btn.tag);
    }
    
    if (btn.tag == _defaultIndex) {
        return;
    } else {
        _titleBtn.selected = !_titleBtn.selected;
        _titleBtn = btn;
        _titleBtn.selected = YES;
        _defaultIndex = btn.tag;
    }
    
    CGFloat offsetX = btn.frame.origin.x - 2 * _btn_w;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxOffsetX = _bgScrollView.contentSize.width - IOScreenWidth;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        _selectLine.frame = CGRectMake(btn.frame.origin.x, self.frame.size.height-2, btn.frame.size.width, 2);
    } completion:^(BOOL finished) {
        NSLog(@"完成偏移");
    }];
}

- (void)setTitleNomalColor:(UIColor *)titleNomalColor {
    _titleNomalColor = titleNomalColor;
    [self updateView];
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor {
    _titleSelectColor = titleSelectColor;
    [self updateView];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    [self updateView];
}

- (void)setDefaultIndex:(NSInteger)defaultIndex {
    _defaultIndex = defaultIndex;
    [self updateView];
}

- (void)updateView {
    for (UIButton *btn in _btns) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = _titleFont;
        _selectLine.backgroundColor = _titleSelectColor;
        
        if (btn.tag - 1 == _defaultIndex - 1) {
            _titleBtn = btn;
            btn.selected = YES;
            _selectLine.frame = CGRectMake(btn.frame.origin.x, self.frame.size.height-2, btn.frame.size.width, 2);
        } else {
            btn.selected = NO;
        }
    }
}

@end
