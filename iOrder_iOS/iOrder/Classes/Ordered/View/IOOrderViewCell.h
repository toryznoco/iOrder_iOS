//
//  IOOrderViewCell.h
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>


//  尺寸
#define kIOOrderViewCellMargin 10
#define kIOOrderViewCellNameWidth 300
#define kkIOOrderViewCellNameHeight 15
#define kIOOrderViewCellStateWidth 50
#define kIOOrderViewCellStateHeight 15
#define kIOOrderViewCellIconWidth 80
#define kIOOrderViewCellIconHeight 60
#define kIOOrderViewCellPaymentWidth 300
#define kIOOrderViewCellPaymentHeight 25
#define kIOOrderViewCellTimeWidth 300
#define kIOOrderViewCellTimeHeight 25

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
