//
//  IOTransmitters.h
//  iOrder
//
//  Created by Tory on 16/5/8.
//  Copyright © 2016年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOTransmitters : NSObject

+ (IOTransmitters *)sharedTransmitters;

- (NSArray *)transmitters;

@end
