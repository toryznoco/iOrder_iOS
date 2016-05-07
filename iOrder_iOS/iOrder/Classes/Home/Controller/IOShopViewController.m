//
//  IOShopViewController.m
//  iOrder
//
//  Created by 易无解 on 4/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShopViewController.h"

#import "IOOrderShopMenuCell.h"
#import "IOOrderShopOptionCell.h"

#import "IODishInfo.h"
#import "IODish.h"
#import "IOBadgeButton.h"

#define kScale 0.25

@interface IOShopViewController ()<UITableViewDataSource, UITableViewDelegate, IOOrderShopMenuCellDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL isRelate;

@property (nonatomic, strong) UITableView *optionTableView;
@property (nonatomic, strong) UITableView *menuTableView;

@property (nonatomic, strong) NSMutableArray *dishInfos;

@property (nonatomic, weak) UIButton *shoppingCarBtn;
@property (nonatomic, weak) UIView *checkOutView;
@property (nonatomic, weak) UILabel *totalPrice;
@property (nonatomic, weak) IOBadgeButton *badge;

@end

@implementation IOShopViewController

#pragma mark - privacy

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    加载数据
    [self dishInfos];
    
    [self setupSelfView];
    
    [self optionTableView];
    
    [self menuTableView];
    
    [self shoppingView];
    
    _isRelate = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.optionTableView) {
        return 1;
    }else{
        return _dishInfos.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    IODishInfo *dishInfo = _dishInfos[section];
    if (tableView == self.optionTableView) {
        return _dishInfos.count;
    }else{
        return dishInfo.dishs.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.optionTableView) {
        cell = [IOOrderShopOptionCell cellWithTableView:tableView];
        
        IODishInfo *dishInfo = _dishInfos[indexPath.row];
        
        ((IOOrderShopOptionCell *)cell).category = dishInfo.category;
    }else{
        cell = [IOOrderShopMenuCell cellWithTableView:tableView];
        ((IOOrderShopMenuCell *)cell).delegate = self;
        
        IODishInfo *dishInfo = _dishInfos[indexPath.section];
        IODish *dish = dishInfo.dishs[indexPath.row];
        
        ((IOOrderShopMenuCell *)cell).dish = dish;
    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.optionTableView) {
        return 51;
    }else{
        return 68;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.optionTableView) {
        return 0;
    }else{
        return 22;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.optionTableView) {
        return 0;
    }else{
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.menuTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 22)];
        view.backgroundColor = YWJRGBColor(217, 217, 217, 0.7);
        
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        IODishInfo *dishInfo = _dishInfos[section];
        label.text = [NSString stringWithFormat:@"   %@", dishInfo.category];
        label.textColor = YWJRGBColor(88, 88, 88, 1);
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        
        return view;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
//      获得一个UITableView的可见部分的第一个cell， 然后算出它属于哪个组
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.menuTableView) {
            [self.optionTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.menuTableView) {
            [self.optionTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.optionTableView) {
        _isRelate = NO;
        [self.optionTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self.menuTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [self.menuTableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _isRelate = YES;
}

#pragma mark - custom methods

- (NSMutableArray *)dishInfos{
    if (!_dishInfos) {
        NSString *dishInfoPath = [[NSBundle mainBundle] pathForResource:@"DishInfos" ofType:@"plist"];
        NSMutableArray *dishData = [NSMutableArray arrayWithContentsOfFile:dishInfoPath];
        NSMutableArray *dishInfosArray = [NSMutableArray array];
        
        for (NSDictionary *dishInfoDic in dishData) {
            IODishInfo *dishInfo = [IODishInfo mj_objectWithKeyValues:dishInfoDic];
            
            NSMutableArray *dishArray = [NSMutableArray array];
            for (NSDictionary *dishDic in dishInfo.dishs) {
                IODish *dish = [IODish mj_objectWithKeyValues:dishDic];
                [dishArray addObject:dish];
            }
            
            dishInfo.dishs = dishArray;
            [dishInfosArray addObject:dishInfo];
        }
        
        _dishInfos = dishInfosArray;
    }
    return _dishInfos;
}

- (UITableView *)optionTableView{
    if (!_optionTableView) {
        _optionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * kScale, self.view.height)];
        _optionTableView.backgroundColor = [UIColor whiteColor];
        _optionTableView.dataSource = self;
        _optionTableView.delegate = self;
        [self.view addSubview:_optionTableView];
    }
    return _optionTableView;
}

- (UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.width * kScale, 0, self.view.width * (1 - kScale), self.view.height)];
        _menuTableView.backgroundColor = [UIColor whiteColor];
        _menuTableView.dataSource = self;
        _menuTableView.delegate = self;
        [self.view addSubview:_menuTableView];
    }
    return _menuTableView;
}

- (void)shoppingView{
    UIView *shoppingView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 54, self.view.width, 54)];
    shoppingView.backgroundColor = [UIColor clearColor];
    CALayer *back = [CALayer layer];
    back.frame = CGRectMake(0, 10, self.view.width, 44);
    back.backgroundColor = YWJRGBColor(238, 240, 241, 1).CGColor;
    [shoppingView.layer addSublayer:back];
    [self.view addSubview:shoppingView];
    
    UIButton *shoppingCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoppingCarBtn.enabled = NO;
    shoppingCarBtn.frame = CGRectMake(25, 0, 44, 44);
    shoppingCarBtn.layer.cornerRadius = 17;
    shoppingCarBtn.clipsToBounds = YES;
    [shoppingCarBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateDisabled];
    [shoppingCarBtn setImage:[UIImage imageNamed:@"barbecue_image"] forState:UIControlStateNormal];
    [shoppingView addSubview:shoppingCarBtn];
    _shoppingCarBtn = shoppingCarBtn;
    
    UILabel *totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shoppingCarBtn.frame) + 5, 24, 200, 14)];
    totalPrice.textColor = [UIColor lightGrayColor];
    totalPrice.font = [UIFont systemFontOfSize:17];
    totalPrice.text = @"购物车是空的";
    _totalPrice = totalPrice;
    [shoppingView addSubview:totalPrice];
    
    UIView *checkOutView = [[UIView alloc] init];
    checkOutView.frame = CGRectMake(self.view.width * (1 - kScale), 10, self.view.width * kScale, 44);
    checkOutView.backgroundColor = [UIColor lightGrayColor];
    [shoppingView addSubview:checkOutView];
    _checkOutView = checkOutView;
    
    UIButton *checkOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkOutView addSubview:checkOutBtn];
    [checkOutBtn setTitle:@"去结算" forState:UIControlStateNormal];
    CGPoint center = CGPointMake(checkOutView.width * 0.5, checkOutView.height * 0.5);
    [checkOutBtn sizeToFit];
    checkOutBtn.center = center;
    [checkOutBtn addTarget:self action:@selector(clickedCheckOut) forControlEvents:UIControlEventTouchUpInside];
    
    IOBadgeButton *badge = [[IOBadgeButton alloc] initWithFrame:CGRectMake(50, 3, 1, 1)];
    _badge = badge;
    [shoppingView addSubview:badge];
}

- (void)setupSelfView{
//    布局就是从导航栏下面开始
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect viewBounds = self.view.bounds;
    float navBarH = self.navigationController.navigationBar.height + 20;
    viewBounds.size.height = YWJMainScreenBounds.size.height - navBarH;
    self.view.bounds = viewBounds;
}

- (void)clickedCheckOut{
    YWJLog(@"点击 结账按钮");
}

#pragma mark shop menu cell delegate

- (void)orderShopMenuCell:(IOOrderShopMenuCell *)shopMenuCell dishPrice:(NSString *)dishPrice clickedBtn:(UIButton *)btn{
    _checkOutView.backgroundColor = [UIColor orangeColor];
    _shoppingCarBtn.enabled = YES;
    _totalPrice.textColor = [UIColor greenColor];
    if ([_totalPrice.text isEqualToString:@"购物车是空的"]) {
        _totalPrice.text = @"0";
    }
    _totalPrice.text = [NSString stringWithFormat:@"¥%lld", ([[_totalPrice.text substringFromIndex:1] longLongValue] + [dishPrice longLongValue])];
}

@end
