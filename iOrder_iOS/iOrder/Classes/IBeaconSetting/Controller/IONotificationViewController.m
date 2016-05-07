//
//  IONotificationViewController.m
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IONotificationViewController.h"

//  尺寸
#define kMargin 20
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

- (void)startMonitoringForReigion {
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

- (void)clickEnterSwitchChanged {
    [self startMonitoringForReigion];
}

- (void)clickExitSwitchChanged {
    [self startMonitoringForReigion];
}

#pragma mark - Custom methods
- (void)setupAllChildView {
    _enterSwitch = [[UISwitch alloc] init];
    _enterSwitch.on = YES;
    [_enterSwitch addTarget:self action:@selector(clickEnterSwitchChanged) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_enterSwitch];
    
    _exitSwitch = [[UISwitch alloc] init];
    _exitSwitch.on = YES;
    [_exitSwitch addTarget:self action:@selector(clickExitSwitchChanged) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_exitSwitch];
    
    _enterLabel = [[UILabel alloc] init];
    _enterLabel.text = @"Enter region notification";
    [self.view addSubview:_enterLabel];
    
    _exitLabel = [[UILabel alloc] init];
    _exitLabel.text = @"Exit region nofification";
    [self.view addSubview:_exitLabel];
}

- (void)setupAllChildViewFrame {
    self.enterLabel.frame = CGRectMake(kMargin, 143, 183, 21);
    self.enterSwitch.frame = CGRectMake(251, 138, self.enterSwitch.bounds.size.width, self.enterSwitch.bounds.size.height);
    self.exitLabel.frame = CGRectMake(kMargin, 194, 171, 21);
    self.exitSwitch.frame = CGRectMake(251, 189, self.exitSwitch.bounds.size.width, self.exitSwitch.bounds.size.height);
}

@end
