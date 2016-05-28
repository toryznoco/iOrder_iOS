//
//  IOProfileViewController.m
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOProfileViewController.h"

#import "IOProfileHeaderView.h"
#import "IOUserInfo.h"
#import "IOProfileCell.h"

@interface IOProfileViewController ()

@property (nonatomic, weak) IOProfileHeaderView *profileHeaderView;

@end

@implementation IOProfileViewController

#pragma mark - privacy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    [self setupTableHeaderView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    //去除导航栏下方的横线 透明
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IOProfileCell *cell = [IOProfileCell cellWithTableView:tableView];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.iconName = @"ecaluate";
                cell.title = @"我的评价";
                break;
            case 1:
                cell.iconName = @"profile_heart";
                cell.title = @"我的收藏";
                break;
            default:
                cell.textLabel.text = @"默认";
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                cell.iconName = @"help";
                cell.title = @"帮助与反馈";
                break;
            case 1:
                cell.iconName = @"more";
                cell.title = @"更多";
                break;
            default:
                cell.textLabel.text = @"默认";
                break;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}


#pragma mark - custom methods

- (void)setupTableHeaderView {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    IOProfileHeaderView *profileHeaderView = [[IOProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 245)];
    _profileHeaderView = profileHeaderView;
    self.tableView.tableHeaderView = profileHeaderView;
    
    IOUserInfo *userInfo = [[IOUserInfo alloc] init];
    userInfo.userIcon = @"weekend_bargain_image";
    userInfo.userName = @"子望";
    userInfo.wallet = 10;
    userInfo.redPacket = 20;
    userInfo.voucher = 30;
    profileHeaderView.userInfo = userInfo;
}

@end
