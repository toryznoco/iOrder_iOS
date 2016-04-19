//
//  YWJTransmitters.m
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJTransmitters.h"

#import "YWJTransmitterTool.h"
#import "YWJHistoryUUIDTool.h"

@implementation YWJTransmitters

#pragma mark - public
+ (YWJTransmitters *)sharedTransmitters{
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

- (NSArray *)transmitters{
    NSArray *result = [YWJTransmitterTool transmitters];
    if (!result) {
        [self setupData];
        result = [YWJTransmitterTool transmitters];
    }
    return result;
}

- (NSArray *)historyUUIDs{
    NSArray *result = [YWJHistoryUUIDTool historyUUIDs];
    if (nil == result) {
        NSArray *transmitters = [self transmitters];
        NSMutableArray *history = [NSMutableArray arrayWithCapacity:transmitters.count];
        for (NSDictionary *data in transmitters) {
            if ([history indexOfObject:data[@"uuid"]] == NSNotFound) {
                [history addObject:data[@"uuid"]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:history forKey:kHistoryUUIDKey];
        result = history;
    }
    return result;
}

- (BOOL)addTransmitter:(NSDictionary *)transmitter{
    NSMutableArray *mutableResult = [[self transmitters] mutableCopy];
    for (NSDictionary *trans in mutableResult) {
        if ([trans[@"uuid"] isEqualToString:transmitter[@"uuid"]]) {
            return NO;
        }
    }
    [mutableResult addObject:transmitter];
    
    [YWJTransmitterTool saveTransmitter:mutableResult];
    return YES;
}

- (BOOL)isExist:(NSString *)uuid{
    NSMutableArray *mutableResult = [[self transmitters] mutableCopy];
    for (NSDictionary *trans in mutableResult) {
        if ([trans[@"uuid"] isEqualToString:uuid]) {
            return YES;
        }
    }
    return NO;
}

- (void)replaceAtIndex:(NSInteger)index withTransmitter:(NSDictionary *)transmitter{
    NSMutableArray *mutableResult = [[self transmitters] mutableCopy];
    [mutableResult replaceObjectAtIndex:index withObject:transmitter];
    [YWJTransmitterTool saveTransmitter:mutableResult];
}

- (void)removeTransmitterAtIndex:(NSInteger)index{
    NSMutableArray *mutableResult = [[self transmitters] mutableCopy];
    if (index < mutableResult.count) {
        [mutableResult removeObjectAtIndex:index];
        [YWJTransmitterTool saveTransmitter:mutableResult];
    }
}

- (void)addHistoryUUID:(NSString *)uuid{
    if (!uuid || uuid.length == 0) {
        return ;
    }
    NSMutableArray *result = [YWJHistoryUUIDTool historyUUIDs];
    if ([result indexOfObject:uuid] == NSNotFound) {
        [result addObject:uuid];
    }
    if (result.count > 20) {
        [result removeObjectAtIndex:0];
    }
    [[NSUserDefaults standardUserDefaults] setObject:result forKey:kHistoryUUIDKey];
}

#pragma mark - private
- (void)setupData{
    NSArray *data =
//  @[
//                      @{
//                          @"name":@"AprilBeacon_7DEB",
//                          @"uuid":@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825",
//                          @"major":@20,
//                          @"minor":@32235,
//                          @"power":@-59
//                          }];
    @[
      @{
          @"name" : @"AprilBeacon",
          @"uuid" : @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0",
          @"major" : @0,
          @"minor" : @0,
          @"power" : @-59
          },
      
      @{
          @"name" : @"Apple AirLocate",
          @"uuid" : @"5A4BCFCE-174E-4BAC-A814-092E77F6B7E5",
          @"major" : @0,
          @"minor" : @0,
          @"power" : @-59
          },
      @{
          @"name" : @"Apple AirLocate2",
          @"uuid" : @"74278BDA-B644-4520-8F0C-720EAF059935",
          @"major" : @0,
          @"minor" : @0,
          @"power" : @-59
          },
      @{
          @"name" : @"ESTimote",
          @"uuid" : @"B9407F30-F5F8-466E-AFF9-25556B57FE6D",
          @"major" : @0,
          @"minor" : @0,
          @"power" : @-59
          },
      
      @{
          @"name" : @"WeixinForBeacon",
          @"uuid" : @"FDA50693-A4E2-4FB1-AFCF-C6EB07647825",
          @"major" : @0,
          @"minor" : @0,
          @"power" : @-59
          }
      ];
    [YWJTransmitterTool saveTransmitter:data];
}

@end
