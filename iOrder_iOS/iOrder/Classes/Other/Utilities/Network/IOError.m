//
//  IOError.m
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOError.h"

@implementation IOError

+ (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description {
    return [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier]
                               code:code
                           userInfo:@{NSLocalizedDescriptionKey: description}];
}

@end
