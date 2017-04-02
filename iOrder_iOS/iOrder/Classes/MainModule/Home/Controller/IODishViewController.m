//
//  IODishViewController.m
//  iOrder
//
//  Created by 易无解 on 5/8/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IODishViewController.h"

#import "UIImageView+WebCache.h"
#import "IODishInfo.h"

#define kScale 0.25

@interface IODishViewController ()

@property (nonatomic, weak) UIImageView *dishImageView;
@property (nonatomic, weak) UIView *dishDetailView;
@property (nonatomic, weak) UIView *evaluateView;

@end

@implementation IODishViewController

#pragma mark - 系统回调函数

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    //去除导航栏下方的横线 透明
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置界面相关函数

- (void)refreshView {
    
    self.view.backgroundColor = IORGBColor(245, 245, 245, 1);
    
    [self setupDishImageView];
    
    [self setupDishDetailView];
    
    [self setupEvaluateView];
}

- (void)setupEvaluateView {
    CGFloat kEvaluateViewHeightRate = 237.0 / 734;
    UIView *evaluateView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dishDetailView.frame) + 2, self.view.width, kEvaluateViewHeightRate * self.view.height)];
    evaluateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:evaluateView];
    _evaluateView = evaluateView;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 25)];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:25];
    title.text = @"商品评价";
    [evaluateView addSubview:title];
    
    UILabel *evaluate = [[UILabel alloc] initWithFrame:CGRectMake(0, evaluateView.height * 0.4, self.view.width, 20)];
    evaluate.textColor = kIOThemeColor;
    evaluate.textAlignment = NSTextAlignmentCenter;
    evaluate.font = [UIFont systemFontOfSize:20];
    evaluate.text = [NSString stringWithFormat:@"好评度 %.0f%%", 80.00];
    [evaluateView addSubview:evaluate];
}

- (void)setupDishDetailView {
    CGFloat kDishDetailHeight = 216.0 / 734;
    UIView *dishDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dishImageView.frame), self.view.width, kDishDetailHeight * self.view.height)];
    dishDetailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dishDetailView];
    _dishDetailView = dishDetailView;
    
    UILabel *dishName = [[UILabel alloc] initWithFrame:CGRectMake(0, dishDetailView.height * 0.2, self.view.width, 25)];
    dishName.font = [UIFont systemFontOfSize:25];
    dishName.textAlignment = NSTextAlignmentCenter;
    dishName.text = _dishInfo.name;
    [dishDetailView addSubview:dishName];
    
    UILabel *saleCount = [[UILabel alloc] initWithFrame:CGRectMake(0, dishDetailView.height * 0.5, self.view.width, 20)];
    saleCount.font = [UIFont systemFontOfSize:20];
    saleCount.textAlignment = NSTextAlignmentCenter;
    saleCount.text = [NSString stringWithFormat:@"月售 %ld", _dishInfo.monthSale];
    [dishDetailView addSubview:saleCount];
    
    UILabel *dishPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, dishDetailView.height * 0.8, self.view.width, 30)];
    dishPrice.font = [UIFont systemFontOfSize:30];
    dishPrice.textAlignment = NSTextAlignmentCenter;
    dishPrice.textColor = kIOThemeColor;
    dishPrice.text = [NSString stringWithFormat:@"¥ %.2f", _dishInfo.nowPrice];
    [dishDetailView addSubview:dishPrice];
}

- (void)setupDishImageView {
    CGFloat kImageViewHeight = 282.0 / 734;
    UIImageView *dishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kImageViewHeight * self.view.height)];
    [self.view addSubview:dishImageView];
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kIOHTTPPictureServerUrl, _dishInfo.picture];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [dishImageView sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    _dishImageView  = dishImageView;
}

@end
