//
//  IONewFeatureViewController.m
//  iOrder
//
//  Created by 易无解 on 4/12/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IONewFeatureViewController.h"

#import "YWJNewFeatureScrollPage.h"

@interface IONewFeatureViewController ()

//@property (nonatomic, strong) UIButton *btn;

@end

@implementation IONewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods
- (void)addChildView{
    YWJNewFeatureScrollPage *scrollPage = [[YWJNewFeatureScrollPage alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height - 20)];
    scrollPage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollPage];
}

@end
