//
//  IOShopDetail.h
//  iOrder
//
//  Created by 易无解 on 8/24/16.
//  Copyright © 2016 normcore. All rights reserved.
//  商店详情的界面

#import <UIKit/UIKit.h>

@class IOShopDetailCellInfo;

#pragma mark - interface IOShopDetail

@interface IOShopDetail : UIView

@end

#pragma mark - interface IOShopDetailCell

@interface IOShopDetailCell : UITableViewCell

@property (nonatomic, strong) IOShopDetailCellInfo *info;
@property (nonatomic, weak) UILabel *detailLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

#pragma mark - interface IOShopDetailCell1

@interface IOShopDetailCell1 : UITableViewCell

@property (nonatomic, strong) IOShopDetailCellInfo *info;
@property (nonatomic, weak) UILabel *detailLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
