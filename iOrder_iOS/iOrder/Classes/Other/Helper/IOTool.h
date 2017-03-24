//
//  IOTool.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#ifndef IOTool_h
#define IOTool_h

#define IOUserDefaults [NSUserDefaults standardUserDefaults]
#define IOKeyWindow [UIApplication sharedApplication].keyWindow
#define IORGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define IOSystemVersion [[UIDevice currentDevice].systemVersion floatValue]

#endif /* IOTool_h */
