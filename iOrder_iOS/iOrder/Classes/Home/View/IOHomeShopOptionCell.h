//
//  IOHomeShopOptionCell.h
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOHomeShopOptionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *category;

@end
