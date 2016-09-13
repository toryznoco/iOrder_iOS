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

#import "IOProfileMyCollectController.h"
#import "IOProfileMyCouponController.h"
#import "IOProfileMyEvaluateController.h"
#import "IOProfileMyPointController.h"

@interface IOProfileViewController ()

@property (nonatomic, weak) IOProfileHeaderView *profileHeaderView;

@end

@implementation IOProfileViewController

#pragma mark - privacy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupNavigationView];
    
    [self setupTableHeaderView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if(section == 1) {
        return 2;
    } else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IOProfileCell *cell = [IOProfileCell cellWithTableView:tableView];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.iconName = @"profile_MyCollect";
                cell.title = @"我的收藏";
                break;
            case 1:
                cell.iconName = @"proflie_MyEvaluate";
                cell.title = @"我的评价";
                break;
                
            case 2:
                cell.iconName = @"profile_-MyAddress";
                cell.title = @"我的地址";
                break;
                
            default:
                cell.textLabel.text = @"默认";
                break;
        }
    } else if(indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.iconName = @"profile_HelpFeedback";
                cell.title = @"帮助与反馈";
                break;
            case 1:
                cell.iconName = @"profile_service";
                cell.title = @"在线服务";
                break;
            default:
                cell.textLabel.text = @"默认";
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                cell.iconName = @"profile_more";
                cell.title = @"更多";
                break;
            default:
                cell.textLabel.text = @"默认";
                break;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    选择将要跳转的界面
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            IOProfileMyCollectController *collectVc = [[IOProfileMyCollectController alloc] init];
            [self.navigationController pushViewController:collectVc animated:YES];
        } else if (indexPath.row == 1) {
            IOProfileMyEvaluateController *evaluateVc = [[IOProfileMyEvaluateController alloc] init];
            [self.navigationController pushViewController:evaluateVc animated:YES];
        }
    } else {
        if (indexPath.row == 0) {
            IOProfileMyCouponController *collectVc = [[IOProfileMyCouponController alloc] init];
            [self.navigationController pushViewController:collectVc animated:YES];
        } else if (indexPath.row == 1) {
            IOProfileMyPointController *evaluateVc = [[IOProfileMyPointController alloc] init];
            [self.navigationController pushViewController:evaluateVc animated:YES];
        }
    }
}


#pragma mark - custom methods

- (void)setupNavigationView {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)setupTableHeaderView {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    IOProfileHeaderView *profileHeaderView = [[IOProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 246)];
    _profileHeaderView = profileHeaderView;
    self.tableView.tableHeaderView = profileHeaderView;
    
    IOUserInfo *userInfo = [[IOUserInfo alloc] init];
    userInfo.userIcon = @"profile_HeadPortrait";
    userInfo.userName = @"SXM12648181460 V2";
    userInfo.wallet = 10;
    userInfo.redPacket = 20;
    userInfo.voucher = 30;
    profileHeaderView.userInfo = userInfo;
}

@end
