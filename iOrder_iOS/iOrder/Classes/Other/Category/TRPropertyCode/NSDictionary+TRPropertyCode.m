//
//  NSDictionary+TRPropertyCode.m
//  TRPropertyCode
//
//  Created by Tory on 2017/1/11.
//  Copyright © 2017年 toryznoco. All rights reserved.
//

#import "NSDictionary+TRPropertyCode.h"

@implementation NSDictionary (TRPropertyCode)

/**
 生成属性代码
 */
- (void)createPropertyCode {
    
    // 有多少个key，生成多少个属性
    NSMutableString *codes = [NSMutableString string];
    
    // 遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *code = nil;
        // 模型中属性根据字典的key
        if ([obj isKindOfClass:[NSString class]]) { // NSString
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;", key];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) { // BOOL
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL *%@;", key];
        } else if ([obj isKindOfClass:[NSNumber class]]) { // NSNumber
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) double %@;", key];
        } else if ([obj isKindOfClass:[NSArray class]]) { // NSArray
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;", key];
        } else if ([obj isKindOfClass:[NSDictionary class]]) { // NSDIctionary
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;", key];
        }
        
        // 拼接字符串
        [codes appendFormat:@"\n%@\n", code];
    }];
    
    NSLog(@"%@", codes);
}

@end
