//
//  IOOrderViewCell.h
//  iOrder
//
//  Created by 易无解 on 4/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IOShop;

@interface IOHomeViewCell : UITableViewCell

/**
 *  店家数据
 */
@property (nonatomic, strong) IOShop *shop;

/**
 *  用于创建一个cell
 *
 *  @return 自定义的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
