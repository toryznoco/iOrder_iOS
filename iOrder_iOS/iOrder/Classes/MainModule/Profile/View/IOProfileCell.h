//
//  IOProfileCell.h
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOProfileCell : UITableViewCell

/**
 图片名称
 */
@property (nonatomic, copy) NSString *iconName;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 使用tableView初始化cell

 @param tableView 将要装入cell的tableView

 @return 返回一个已经实例化的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
