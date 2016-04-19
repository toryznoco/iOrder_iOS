//
//  IOOrderViewController.m
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOOrderViewController.h"

#import "IOOrderViewCell.h"
#import "IOShopInfo.h"

@interface IOOrderViewController ()

@property (nonatomic, strong) NSMutableArray *shopInfos;

@end

@implementation IOOrderViewController

#pragma mark - privacy

- (NSMutableArray *)shopInfos{
    if (!_shopInfos) {
        NSString *shopInfosPath = [[NSBundle mainBundle] pathForResource:@"ShopInfos" ofType:@"plist"];
        NSMutableArray *shopDatas = [NSMutableArray arrayWithContentsOfFile:shopInfosPath];
        NSMutableArray *shopInfosArray = [NSMutableArray array];
        
        for (NSDictionary *dic in shopDatas) {
            IOShopInfo *shopInfo = [IOShopInfo objectWithKeyValues:dic];
            [shopInfosArray addObject:shopInfo];
        }
        
        _shopInfos = shopInfosArray;
    }
    return _shopInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Order";
    self.view.backgroundColor = [UIColor whiteColor];
    //    设置行高
    self.tableView.rowHeight = 70;
    
    _shopInfos = [self shopInfos];
    //    YWJLog(@"%@", _shopInfos);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shopInfos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IOOrderViewCell *cell = [IOOrderViewCell cellWithTableView:tableView];
    
    IOShopInfo *info = self.shopInfos[indexPath.row];
    cell.shopInfo = info;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
