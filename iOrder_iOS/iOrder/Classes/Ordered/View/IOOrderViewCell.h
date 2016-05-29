//
//  IOOrderViewCell.h
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IOOrder;
@interface IOOrderViewCell : UITableViewCell

/**
 *  订单数据
 */
@property (nonatomic, strong) IOOrder *order;

/**
 *  用于创建一个cell
 *
 *  @return 自定义的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
