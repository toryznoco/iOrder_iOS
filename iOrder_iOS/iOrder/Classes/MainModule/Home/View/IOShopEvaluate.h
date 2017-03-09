//
//  IOShopEvaluate.h
//  iOrder
//
//  Created by 易无解 on 8/24/16.
//  Copyright © 2016 normcore. All rights reserved.
//  商店评价的界面

#import <UIKit/UIKit.h>

#pragma mark - interface IOShopEvaluate

@interface IOShopEvaluate : UIView

@end

#pragma mark - interface IOShopEvaluateHeaderView

@interface IOShopEvaluateHeaderView : UIView

@end

#pragma mark - interface IOShopEvaluateCell

@interface IOShopEvaluateCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
