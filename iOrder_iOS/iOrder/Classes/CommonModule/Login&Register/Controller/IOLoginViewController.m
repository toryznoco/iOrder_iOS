//
//  IOLoginViewController.m
//  iOrder
//
//  Created by 易无解 on 8/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOLoginViewController.h"
#import "IOLoginView.h"

#import "IOTabBarController.h"
#import "IORegisterViewController.h"

@interface IOLoginViewController ()<IOLoginViewDelegate>

@end

@implementation IOLoginViewController

#pragma mark - privacy

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - custom

- (void)refreshView {//刷新控制器的View
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationView];
    
    [self setupAllChildView];
}

- (void)setupNavigationView {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)setupAllChildView {//添加所有的子视图
    //添加子视图用于自动布局
    IOLoginView *loginView = [[IOLoginView alloc] initWithFrame:self.view.frame];
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

#pragma mark - IOLoginViewDelegate

- (void)loginView:(IOLoginView *)loginView registerBtnDidPressed:(UIButton *)registerBtn {
    IORegisterViewController *registerVc = [[IORegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (void)loginView:(IOLoginView *)loginView loginBtnDidPressed:(UIButton *)loginBtn {
    IOKeyWindow.rootViewController = [[IOTabBarController alloc] init];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
