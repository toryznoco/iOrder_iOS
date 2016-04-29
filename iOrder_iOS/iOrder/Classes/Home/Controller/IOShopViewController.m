//
//  IOShopViewController.m
//  iOrder
//
//  Created by 易无解 on 4/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShopViewController.h"

@interface IOShopViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL isRelate;

@property (nonatomic, strong) UITableView *optionTableView;
@property (nonatomic, strong) UITableView *menuTableView;

@end

@implementation IOShopViewController

#pragma mark - privacy

- (UITableView *)optionTableView{
    if (!_optionTableView) {
        _optionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.height)];
        _optionTableView.backgroundColor = [UIColor whiteColor];
        _optionTableView.dataSource = self;
        _optionTableView.delegate = self;
        [self.view addSubview:_optionTableView];
    }
    return _optionTableView;
}

- (UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(100, 0, self.view.width - 100, self.view.height)];
        _menuTableView.backgroundColor = [UIColor whiteColor];
        _menuTableView.dataSource = self;
        _menuTableView.delegate = self;
        [self.view addSubview:_menuTableView];
    }
    return _menuTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSelfView];
    
    [self loadNewData];
    
    [self optionTableView];
    
    [self menuTableView];
    
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
        return [_dataArray count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *item = _dataArray[section];
    if (tableView == self.optionTableView) {
        return [_dataArray count];
    }else{
        return [item[@"list"] count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"menuCell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseId];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (tableView == self.optionTableView) {
        UIView *selectedBgView = [[UIView alloc] initWithFrame:cell.frame];
        selectedBgView.backgroundColor = YWJRGBColor(217, 217, 217, 0.5);
        cell.selectedBackgroundView = selectedBgView;
        
        UIView *liner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 60)];
        liner.backgroundColor = [UIColor orangeColor];
        [selectedBgView addSubview:liner];
        
        cell.textLabel.text = _dataArray[indexPath.row][@"title"];
    }else{
        NSDictionary *item = _dataArray[indexPath.section];
        cell.textLabel.text = item[@"list"][indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.optionTableView) {
        return 60;
    }else{
        return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.optionTableView) {
        return 0;
    }else{
        return 30;
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
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 30)];
        view.backgroundColor = YWJRGBColor(217, 217, 217, 0.7);
        
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        NSDictionary *item = _dataArray[section];
        NSString *title = item[@"title"];
        label.text = [NSString stringWithFormat:@"   %@", title];
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
        YWJLog(@"+++++ %ld", topCellSection);
        if (tableView == self.menuTableView) {
            [self.optionTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        YWJLog(@"----- %ld", topCellSection);
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

- (void)setupSelfView{
//    布局就是从导航栏下面开始
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect viewBounds = self.view.bounds;
    float navBarH = self.navigationController.navigationBar.height + 20;
    viewBounds.size.height = YWJMainScreenBounds.size.height - navBarH;
    self.view.bounds = viewBounds;
}

- (void)loadNewData{
    _dataArray = @[
                   @{@"title" : @"00",
                     @"list" : @[@"Soldier", @"aaa0", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa1", @"aaa"]
                     },
                   @{@"title" : @"01",
                     @"list" : @[@"Soldier", @"aaa1", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa1", @"aaa"]
                     },
                   @{@"title" : @"02",
                     @"list" : @[@"Soldier", @"aaa2", @"aaa"]
                     },
                   @{@"title" : @"03",
                     @"list" : @[@"Soldier", @"aaa3", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa1", @"aaa"]
                     },
                   @{@"title" : @"04",
                     @"list" : @[@"Soldier", @"aaa4", @"aaa"]
                     },
                   @{@"title" : @"05",
                     @"list" : @[@"Soldier", @"aaa5", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa1", @"aaa"]
                     },
                   @{@"title" : @"06",
                     @"list" : @[@"Soldier", @"aaa6", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa"]
                     },
                   @{@"title" : @"07",
                     @"list": @[@"Soldier", @"aaa7", @"aaa"]
                     },
                   @{@"title": @"08",
                     @"list": @[@"Soldier" ,@"aaa8", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa"]
                     },
                   @{@"title" : @"09",
                     @"list" : @[@"Soldier", @"aaa9", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa"]
                     },
                   @{@"title" : @"10",
                     @"list" : @[@"Soldier", @"aaa10", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa"]
                     },
                   @{@"title" : @"11",
                     @"list" : @[@"Soldier", @"aaa11", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa"]
                     },
                   @{@"title" : @"12",
                     @"list" : @[@"Soldier", @"aaa12", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa1", @"aaa"]
                     },
                   @{@"title" : @"13",
                     @"list" : @[@"Soldier", @"aaa13", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa1", @"aaa"]
                     },
                   @{@"title" : @"14",
                     @"list" : @[@"Soldier", @"aaa14", @"aaa", @"aaa", @"aaa1", @"aaa", @"aaa", @"aaa", @"aaa"]
                     },
                   @{@"title" : @"15",
                     @"list" : @[@"Soldier", @"aaa15", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa1", @"aaa"]
                     },
                   @{@"title" : @"16",
                     @"list" : @[@"Soldier", @"aaa16", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa", @"aaa"]
                     }
                   ];
}

@end
