//
//  IOSingInViewController.m
//  iOrder
//
//  Created by Tory on 16/5/18.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOSingInViewController.h"
#import "IOSignInHeaderView.h"

@interface IOSingInViewController ()

@property (nonatomic, weak) UIView *signInHeaderView;
@property (nonatomic, weak) UIView *calendarView;

@end

@implementation IOSingInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHeaderView];
}

- (void)initHeaderView {
    IOSignInHeaderView *signInHeaderView = [[IOSignInHeaderView alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, 342)];
    [self.view addSubview:signInHeaderView];
    _signInHeaderView = signInHeaderView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
