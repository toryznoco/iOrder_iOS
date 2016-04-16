//
//  IOIBeaconViewController.m
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOIBeaconViewController.h"

#import "IONotificationViewController.h"

#import "YWJTransmitters.h"

@interface IOIBeaconViewController ()

@property (nonatomic, strong) ABBeaconManager *beaconManager;
@property (nonatomic, strong) NSMutableDictionary *tableData;

@end

@implementation IOIBeaconViewController

#pragma mark - self
- (NSMutableDictionary *)tableData{
    if (!_tableData) {
        _tableData = [NSMutableDictionary dictionary];
    }
    return _tableData;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startRangeBeacons];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iBeacon";
    
//    创建beacon管理员
    self.beaconManager = [[ABBeaconManager alloc] init];
//    设置代理
    self.beaconManager.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRangeBeacons) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopRangeBeacons];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_tableData allValues][section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"IOBeaconCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    ABBeacon *beacon = [_tableData allValues][indexPath.section][indexPath.row];
    cell.textLabel.text = [beacon.proximityUUID UUIDString];
    
    NSString *proximity;
    switch (beacon.proximity) {
        case CLProximityFar:
            proximity = @"Far";
            break;
            
        case CLProximityImmediate:
            proximity = @"Immediate";
            break;
            
        case CLProximityNear:
            proximity = @"Near";
            break;
            
        default:
            proximity = @"Unknown";
            break;
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Major: %@, Minor: %@, Acc: %.2fm, proximity=%@", beacon.major, beacon.minor, [beacon.distance floatValue], proximity];
    
    
    return cell;
}

#pragma mark - ABBeaconManagerDelegate
- (void)beaconManager:(ABBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ABBeaconRegion *)region{
    [self.refreshControl endRefreshing];
    [_tableData removeObjectForKey:region];
    [_tableData setObject:beacons forKey:region];
    [self.tableView reloadData];
}

- (void)beaconManager:(ABBeaconManager *)manager rangingBeaconsDidFailForRegion:(ABBeaconRegion *)region withError:(NSError *)error{
    [self.refreshControl endRefreshing];
    [_tableData removeObjectForKey:region];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ABBeacon *beacon = [_tableData allValues][indexPath.section][indexPath.row];
    
    IONotificationViewController *vc = [[IONotificationViewController alloc] init];
    vc.beaconn = beacon;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Custom methods
- (void)startRangeBeacons{
    [self stopRangeBeacons];
    
    YWJTransmitters *tran = [YWJTransmitters sharedTransmitters];
    [[tran transmitters] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:obj[@"uuid"]];
        NSString *regionIdentifier = obj[@"uuid"];
        
        ABBeaconRegion *beaconRegion = [[ABBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:regionIdentifier];
        beaconRegion.notifyOnEntry = YES;
        beaconRegion.notifyOnExit = YES;
        beaconRegion.notifyEntryStateOnDisplay = YES;
        [_beaconManager startRangingBeaconsInRegion:beaconRegion];
    }];
}

- (void)stopRangeBeacons{
    YWJTransmitters *tran = [YWJTransmitters sharedTransmitters];
    [[tran transmitters] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:obj[@"uuid"]];
        NSString *regionIdentifier = obj[@"uuid"];
        
        ABBeaconRegion *beaconRegion = [[ABBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:regionIdentifier];
        [_beaconManager stopRangingBeaconsInRegion:beaconRegion];
    }];
}

@end
