//
//  IOShopCell.h
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IODish, IOShopMenuCell;


#pragma mark - interface IOShopMenuCell
@protocol IOShopMenuCellDelegate <NSObject>

- (void)shopMenuCell:(IOShopMenuCell *)shopMenuCell dishPrice:(float)dishPrice clickedBtn:(UIButton *)btn;

@end

@interface IOShopMenuCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IODish *dish;

@property (nonatomic, weak) id<IOShopMenuCellDelegate> delegate;

@end


#pragma mark - interface IOShopOptionCell
@interface IOShopOptionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *category;

@end