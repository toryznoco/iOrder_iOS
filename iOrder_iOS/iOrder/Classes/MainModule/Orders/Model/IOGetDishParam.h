//
//  IOGetDishParam.h
//  iOrder
//
//  Created by Tory on 03/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseParam.h"

@interface IOGetDishParam : IOHTTPBaseParam

/** orderId */
@property (nonatomic, assign) NSInteger orderId;

@end
