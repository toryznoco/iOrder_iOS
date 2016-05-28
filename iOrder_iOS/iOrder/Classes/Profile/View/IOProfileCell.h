//
//  IOProfileCell.h
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOProfileCell : UITableViewCell

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
