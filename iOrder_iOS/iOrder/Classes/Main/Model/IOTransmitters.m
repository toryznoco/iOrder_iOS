//
//  IOTransmitters.m
//  iOrder
//
//  Created by Tory on 16/5/8.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOTransmitters.h"

#define kTransmitterKey @"transmitters"

@implementation IOTransmitters

#pragma mark - public
+ (IOTransmitters *)sharedTransmitters {
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

- (NSArray *)transmitters {
    NSArray *result = [[NSUserDefaults standardUserDefaults] arrayForKey:kTransmitterKey];
    if (nil == result) {
        [self setupData];
        result = [[NSUserDefaults standardUserDefaults] arrayForKey:kTransmitterKey];
    }
    return result;
}

- (BOOL)isExist:(NSString *)uuid {
    NSMutableArray *mutableResult = [[self transmitters] mutableCopy];
    for (NSDictionary *trans in mutableResult) {
        if ([trans[@"uuid"] isEqualToString:uuid]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - private
- (void)setupData {
    NSArray *data =@[
                     @{
                         @"name":@"AprilBeacon_7DEB",
                         @"uuid":@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825",
                         @"major":@20,
                         @"minor":@32235,
                         @"power":@-59
                         },
                     @{
                         @"name":@"AprilBeacon_866F",
                         @"uuid":@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825",
                         @"major":@20,
                         @"minor":@34415,
                         @"power":@-58
                         }
                     ];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kTransmitterKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
