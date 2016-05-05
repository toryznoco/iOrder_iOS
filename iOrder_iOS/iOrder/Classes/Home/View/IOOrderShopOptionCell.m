//
//  IOOrderShopOptionCell.m
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOOrderShopOptionCell.h"

@implementation IOOrderShopOptionCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"optionCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
