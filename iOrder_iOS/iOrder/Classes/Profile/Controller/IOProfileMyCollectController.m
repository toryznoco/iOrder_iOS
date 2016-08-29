//
//  IOProfileMyCollectController.m
//  iOrder
//
//  Created by 易无解 on 8/29/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOProfileMyCollectController.h"

#import "IOProfileMyCollectView.h"

@interface IOProfileMyCollectController ()

@end

@implementation IOProfileMyCollectController

#pragma mark - privace

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"collect";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupAllChildView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public

#pragma mark - custom

- (void)setupAllChildView {
    IOProfileMyCollectView *collectView = [[IOProfileMyCollectView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:collectView];
}

@end
