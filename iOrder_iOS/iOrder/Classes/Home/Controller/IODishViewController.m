//
//  IODishViewController.m
//  iOrder
//
//  Created by 易无解 on 5/8/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IODishViewController.h"

#import "IOShoppingCartView.h"

#define kScale 0.25

@interface IODishViewController ()

@property (nonatomic, weak) IOShoppingCartView *shoppingCartView;

@end

@implementation IODishViewController

#pragma mark - privacy
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *igv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005"]];
    igv.frame = CGRectMake(100, 20, 50, 150);
    [self.view addSubview:igv];
    
    [self setupShoppingCartView];
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

#pragma mark - public

#pragma mark - custom

- (void)setupShoppingCartView {
    IOShoppingCartView *shoppingCartView = [[IOShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.height - 54, self.view.width, 54)];
    [self.view addSubview:shoppingCartView];
    _shoppingCartView = shoppingCartView;
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
