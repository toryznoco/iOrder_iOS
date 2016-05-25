//
//  IOSubmitViewController.m
//  iOrder
//
//  Created by 易无解 on 5/23/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOSubmitViewController.h"

#import "UIBarButtonItem+IOBarButtonItem.h"
#import "IOSubmitOrderView.h"

@interface IOSubmitViewController ()

@property (nonatomic, weak) IOSubmitOrderView *submitOrderView;

@end

@implementation IOSubmitViewController

#pragma mark - privacy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setupNavigationItem];
    
    [self setupSubmitOrderView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */
#pragma mark - custom methods

- (void)setupSubmitOrderView {
    IOSubmitOrderView *submitOrderView = [[IOSubmitOrderView alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    [self.view addSubview:submitOrderView];
    _submitOrderView = submitOrderView;
    
    submitOrderView.price = _totalPrice;
}

- (void)setupNavigationItem {
    self.title = @"提交订单";
    UIColor *titleColor = [UIColor whiteColor];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = titleColor;
    self.navigationController.navigationBar.titleTextAttributes = titleAttr;
    UIBarButtonItem *backBtn = [UIBarButtonItem initWithNormalImage:@"arrow" target:self action:@selector(backBtnClick) width:12 height:21];
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
