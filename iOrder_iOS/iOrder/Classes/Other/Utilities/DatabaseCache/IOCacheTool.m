//
//  IOCacheTool.m
//  iOrder
//
//  Created by 易无解 on 9/21/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOCacheTool.h"

#import "FMDB.h"
#import "IOLoginParam.h"
#import "IOLoginResult.h"
#import "IONearbyShopsResult.h"
#import "IONearbyShopsParam.h"

#import "MJExtension.h"

@implementation IOCacheTool

static FMDatabase *_db;

+ (void)initialize {
    
    //    1.获取缓存路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //    2.拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"iOrder.sqlite"];
    //    3.创建数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    //    4.打开数据库
    if ([_db open]) {
        NSLog(@"open successful");
    } else {
        NSLog(@"open failed");
    }
}

#pragma mark - userInfo

+ (void)saveUserInfoWithLoginParam:(IOLoginParam *)param andLoginResult:(IOLoginResult *)result {
//    创建表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_users (id integer primary key autoincrement, account text, password text, userInfo blob);"];
    if (flag) {
        NSLog(@"create t_users successful");
        NSMutableDictionary *dic = result.mj_keyValues;
        NSLog(@"%@", dic);
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:result.mj_keyValues];
        
        //        判断记录是否已经存在
        NSString *sql = [NSString stringWithFormat:@"select * from t_users where account = '%@' and password = '%@'", param.account, param.password];
        FMResultSet *queryResult = [_db executeQuery:sql];
        [queryResult next];
        BOOL flag2 = ([[queryResult stringForColumn:@"account"] isEqualToString:param.account] && [[queryResult stringForColumn:@"password"] isEqualToString:param.password]);
        
        if (flag2) {
            IOLog(@"The data has exists");
        } else {//插入新记录
            BOOL flag3 = [_db executeUpdate:@"insert into t_users (account, password, userInfo) values(?, ?, ?)", param.account, param.password, data];
            if (flag3) {
                IOLog(@"insert data - userInfo successful");
            } else {
                IOLog(@"insert data - userInfo failed");
            }
        }
    } else {
        NSLog(@"create t_users failed");
    }
}

+ (IOLoginResult *)loginResultWithLoginParam:(IOLoginParam *)param {
//    编写查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from t_users where account = '%@' and password = '%@'", param.account, param.password];
    FMResultSet *set = [_db executeQuery:sql];
    if ([set next]) {
        NSData *data = [set dataForColumn:@"userInfo"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        IOLoginResult *loginResult = [IOLoginResult mj_objectWithKeyValues:dict];
        return loginResult;
    } else {
        return nil;
    }
}

#pragma mark - ShopInfo
+ (void)saveShopInfoWithShopParam:(IONearbyShopsParam *)param andShopResult:(id)result {
    BOOL flag = [_db executeUpdate:@"create table if not exists t_shops (id integer primary key autoincrement, pageNum integer, pageSize integer, lng double, lat double, shopInfo blob);"];
    if (flag) {
        NSLog(@"create t_shops successful");
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:result];
        //        判断记录是否已经存在
        NSString *sql = [NSString stringWithFormat:@"select * from t_shops where pageNum = %ld and pageSize = %ld and lng = %lf and lat = %lf", param.pageNum, param.pageSize, param.lng, param.lat];
        FMResultSet *queryResult = [_db executeQuery:sql];
        [queryResult next];
        BOOL flag2 = ([queryResult intForColumn:@"pageNum"] == param.pageNum && [queryResult intForColumn:@"pageSize"] == param.pageSize && [queryResult intForColumn:@"lng"] == param.lng && [queryResult intForColumn:@"lat"] == param.lat);
        
        if (flag2) {
            IOLog(@"The data has exists");
        } else {//插入新记录
            BOOL flag3 = [_db executeUpdate:@"insert into t_shops (pageNum, pageSize, lng, lat, shopinfo) values(?, ?, ?, ?, ?)", @(param.pageNum), @(param.pageSize), @(param.lng), @(param.lat), data];
            if (flag3) {
                IOLog(@"insert data - shopInfo successful");
            } else {
                IOLog(@"insert data - shopInfo failed");
            }
        }
    } else {
        IOLog(@"create t_shops failed");
    }
}

+ (IONearbyShopsResult *)shopResultWithShopParam:(IONearbyShopsParam *)param {
    //    编写查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from t_shops where pageNum = %ld and pageSize = %ld and lng = %lf and lat = %lf", param.pageNum, param.pageSize, param.lng, param.lat];
    FMResultSet *set = [_db executeQuery:sql];
    if ([set next]) {
        NSData *data = [set dataForColumn:@"shopInfo"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        IONearbyShopsResult *shopResult = [IONearbyShopsResult mj_objectWithKeyValues:dict];
        return shopResult;
    } else {
        return nil;
    }
}

@end
