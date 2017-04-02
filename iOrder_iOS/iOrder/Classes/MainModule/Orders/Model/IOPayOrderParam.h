//
//  IOPayOrderParam.h
//  iOrder
//
//  Created by Tory on 02/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseParam.h"

@interface IOPayOrderParam : IOHTTPBaseParam

/** orderId */
@property (nonatomic, assign) NSInteger orderId;

@end
