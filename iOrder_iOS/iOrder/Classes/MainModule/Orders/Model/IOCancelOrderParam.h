//
//  IOCancelOrderParam.h
//  iOrder
//
//  Created by Tory on 08/05/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseParam.h"

@interface IOCancelOrderParam : IOHTTPBaseParam

/** orderId */
@property (nonatomic, assign) NSInteger orderId;

@end
