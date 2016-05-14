//
//  IOHomeShopCell.h
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IODish, IOHomeShopMenuCell;


#pragma mark - interface IOHomeShopMenuCell
@protocol IOHomeShopMenuCellDelegate <NSObject>

- (void)homeShopMenuCell:(IOHomeShopMenuCell *)shopMenuCell dishPrice:(float)dishPrice clickedBtn:(UIButton *)btn;

@end

@interface IOHomeShopMenuCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IODish *dish;

@property (nonatomic, weak) id<IOHomeShopMenuCellDelegate> delegate;

@end


#pragma mark - interface IOHomeShopOptionCell
@interface IOHomeShopOptionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *category;

@end