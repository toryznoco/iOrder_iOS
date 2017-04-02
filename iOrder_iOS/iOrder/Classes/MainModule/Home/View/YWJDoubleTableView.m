//
//  YWJDoubleTableView.m
//  iOrder
//
//  Created by 易无解 on 5/17/16.
//  Copyright © 2016 normcore. All rights reserved.
//  

#import "YWJDoubleTableView.h"

#import "IOShopCell.h"
#import "IODishInfo.h"
#import "YWJShoppingCartTool.h"

#define kScale 0.25

@interface YWJDoubleTableView ()<UITableViewDataSource, UITableViewDelegate, IOShopRightCellDelegate>

@property (nonatomic, assign) BOOL isRelate;

@end

@implementation YWJDoubleTableView

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
        _isRelate = YES;
    }
    return self;
}

#pragma mark - public

- (void)setDishInfos:(NSMutableArray *)dishInfos{
    _dishInfos = dishInfos;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    [_leftTableView reloadData];
    [_rightTableView reloadData];
}

#pragma mark - custom method

- (void)setupAllChildView {//添加所有的子控件
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width * kScale, self.height)];
    leftTableView.backgroundColor = [UIColor whiteColor];
    _leftTableView = leftTableView;
    _leftTableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:leftTableView];
    
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.width * kScale, 0, self.width * (1 - kScale), self.height)];
    rightTableView.backgroundColor = [UIColor whiteColor];
    _rightTableView = rightTableView;
    [self addSubview:rightTableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {//刷新左右两边tableView中的分组个数
    if (tableView == _leftTableView) {
        return 1;
    }else{
        return _dishInfos.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {//刷新tableView中的数据
    IODishCategory *dishInfo = _dishInfos[section];
    if (tableView == self.leftTableView) {
        return _dishInfos.count;
    }else{
        return dishInfo.goodsList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.leftTableView) {
        cell = [IOShopLeftCell cellWithTableView:tableView];
        
        IODishCategory *dishInfo = _dishInfos[indexPath.row];
        
        ((IOShopLeftCell *)cell).category = dishInfo.name;
    }else{
        cell = [IOShopRightCell cellWithTableView:tableView];
        ((IOShopRightCell *)cell).delegate = self;
        IODishCategory *dishInfo = _dishInfos[indexPath.section];
        IODish *dish = dishInfo.goodsList[indexPath.row];
        
        ((IOShopRightCell *)cell).dish = dish;
    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 51;
    }else{
        return 68;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 0;
    }else{
        return 22;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 0;
    }else{
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 22)];
        view.backgroundColor = IORGBColor(217, 217, 217, 0.7);
        
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        IODishCategory *dishInfo = _dishInfos[section];
        label.text = [NSString stringWithFormat:@"   %@", dishInfo.name];
        label.textColor = IORGBColor(88, 88, 88, 1);
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        
        return view;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (_isRelate) {
        //      获得一个UITableView的可见部分的第一个cell， 然后算出它属于哪个组
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        _isRelate = NO;
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        IODishCategory *dishCategory = _dishInfos[indexPath.row];
        NSLog(@"%ld", dishCategory.goodsList.count);
        if (dishCategory.goodsList.count == 0) {
            [self.rightTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionNone animated:YES];
        } else {
            [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }else{
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:NO];
        
        if ([self.delegate respondsToSelector:@selector(doubleTableView:didSelectRowAtIndexPath:)]) {
            [self.delegate doubleTableView:self didSelectRowAtIndexPath:indexPath];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isRelate = YES;
}

#pragma mark shop right cell delegate

- (void)shopRightCell:(IOShopRightCell *)shopRightCell dishPrice:(float)dishPrice clickedBtn:(UIButton *)btn {
    if (btn.tag == 1) {
        [YWJShoppingCartTool addDishToShoppingCartWithUserId:1 dishesId:shopRightCell.dish.goodsId amount:1 success:^{
            IOLog(@"成功");
        } failure:^(NSError *error) {
            IOLog(@"%@", error);
        }];
    } else {
        
        [YWJShoppingCartTool removeDishFromShoppingCartWithUserId:1 dishesId:shopRightCell.dish.goodsId amount:1 success:^{
            IOLog(@"移除");
        } failure:^(NSError *error) {
            IOLog(@"%@", error);
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(doubleTableView:dishPrice:clickedBtn:)]) {
        [self.delegate doubleTableView:self dishPrice:dishPrice clickedBtn:btn];
    }
}

@end
