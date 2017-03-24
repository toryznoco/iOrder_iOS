//
//  IOError.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IOErrorCode){
    IOErrorCodeTokenInvalid = 401,
    IOErrorCodeCommon = 14700,
    IOErrorCodeServerDisable,
    IOErrorCodeNetworkDisable
};

@interface IOError : NSError

+ (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description;

@end
