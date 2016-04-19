//
//  YWJTransmitters.h
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJTransmitters : NSObject

+ (YWJTransmitters *)sharedTransmitters;

- (NSArray *)transmitters;
- (NSArray *)historyUUIDs;
- (void)addHistoryUUID:(NSString *)uuid;
- (BOOL)addTransmitter:(NSDictionary *)transmitter;
- (void)replaceAtIndex:(NSInteger)index withTransmitter:(NSDictionary *)transmitter;
- (void)removeTransmitterAtIndex:(NSInteger)index;

@end
