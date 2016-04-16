//
//  IONotificationViewController.m
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IONotificationViewController.h"

#define kMargin 10
#define kEnter self.view.height * 0.4
#define kExit self.view.height * 0.5

@interface IONotificationViewController ()

@property (nonatomic, strong) ABBeaconManager *beaconManager;
@property (nonatomic, strong) UISwitch *enterSwitch;
@property (nonatomic, strong) UISwitch *exitSwitch;
@property (nonatomic, strong) UILabel *enterLabel;
@property (nonatomic, strong) UILabel *exitLabel;

@property (nonatomic, strong) ABBeaconRegion *region;

@end

@implementation IONotificationViewController

#pragma mark - privacy
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildView];
    [self setupAllChildViewFrame];
    
    self.beaconManager = [[ABBeaconManager alloc] init];
    _beaconManager.delegate = self;
    
    [self startMonitoringForReigion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)startMonitoringForReigion{
    if (!_region) {
        self.region = [[ABBeaconRegion alloc] initWithProximityUUID:_beaconn.proximityUUID identifier:_beaconn.proximityUUID.UUIDString];
    }else{
        [_beaconManager stopMonitoringForRegion:self.region];
    }
    
    self.region.notifyOnEntry = _enterSwitch.on;
    self.region.notifyOnExit = _exitSwitch.on;
    self.region.notifyEntryStateOnDisplay = YES;
    [_beaconManager startMonitoringForRegion:self.region];
}

- (void)setupAllChildView{
    _enterSwitch = [[UISwitch alloc] init];
    [_enterSwitch addTarget:self action:@selector(clickEnterSwitchChanged) forControlEvents:UIControlEventTouchUpInside];
    
    _exitSwitch = [[UISwitch alloc] init];
    [_exitSwitch addTarget:self action:@selector(clickExitSwitchChanged) forControlEvents:UIControlEventTouchUpInside];
    
    _enterLabel = [[UILabel alloc] init];
    _enterLabel.text = @"Enter region notification";
    
    _exitLabel = [[UILabel alloc] init];
    _exitLabel.text = @"Exit region nofification";
}

- (void)setupAllChildViewFrame{
    self.enterLabel.frame = CGRectMake(kMargin, kEnter, self.enterLabel.bounds.size.width, self.enterLabel.bounds.size.height);
    self.enterSwitch.frame = CGRectMake(self.view.width - self.enterSwitch.bounds.size.width - kMargin, kEnter, self.enterLabel.bounds.size.width, self.enterLabel.bounds.size.height);
    self.exitLabel.frame = CGRectMake(kMargin, kExit, self.enterLabel.bounds.size.width, self.enterLabel.bounds.size.height);
    self.exitSwitch.frame = CGRectMake(self.view.width - self.exitSwitch.bounds.size.width - kMargin, kExit, self.enterLabel.bounds.size.width, self.enterLabel.bounds.size.height);
}

- (void)clickEnterSwitchChanged{
    [self startMonitoringForReigion];
}

- (void)clickExitSwitchChanged{
    [self startMonitoringForReigion];
}

@end
