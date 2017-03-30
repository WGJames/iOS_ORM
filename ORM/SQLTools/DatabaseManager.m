//
//  DatabaseManager.m
//  ORM
//
//  Created by JamesCheng on 2017/3/24.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import "DatabaseManager.h"
#import "User.h"
static NSString *const NSDATE_DEFAULT_FORMART = @"yyyy-MM-dd";
static DatabaseManager *sharedDBManager = nil;
@implementation DatabaseManager
@synthesize database;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDBManager = [super allocWithZone:zone];
    });
    return sharedDBManager;
}

+ (DatabaseManager *)sharedDatabaseManager {
    return [[self alloc] init];
}

- (void)initDatabaseWithFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths firstObject];
    filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"/%@.db",fileName]];
    NSLog(@"database file path is %@",filePath);
    database = [FMDatabase databaseWithPath:filePath];
    [self openCurrentDatabase];
    [User createTableSQLOperation];
}

- (void)openCurrentDatabase {
    if ([database open]) {
        [database setDateFormat:[FMDatabase storeableDateFormat:NSDATE_DEFAULT_FORMART]];
    } else {
        NSLog(@"the database couldn't open!");
    }
}

- (void)closeCurrentDatabase {
    if (![database close]) {
        NSLog(@"the database couldn't close!");
    }
}

- (BOOL)executeUpdateWithSQL:(void(^)(SQLTool<beginProtocolList> *tool))block {
    if (block) {
        SQLTool<beginProtocolList> *tool = [[SQLTool<beginProtocolList> alloc] init];
        block(tool);
        return [database executeUpdate:tool.SQLString];
    }
    return NO;
};

- (BOOL)executeUpdateWithSQL:(void(^)(SQLTool<beginProtocolList> *tool))block Array:(NSArray *)array {
    if (block) {
        SQLTool<beginProtocolList> *tool = [[SQLTool<beginProtocolList> alloc] init];
        block(tool);
        return [database executeUpdate:tool.SQLString withArgumentsInArray:array];
    }
    return NO;
}

- (BOOL)executeUpdateWithSQL:(void(^)(SQLTool<beginProtocolList> *tool))block Dictionary:(NSDictionary *)dictionary {
    if (block) {
        SQLTool<beginProtocolList> *tool = [[SQLTool<beginProtocolList> alloc] init];
        block(tool);
        return [database executeUpdate:tool.SQLString withParameterDictionary:dictionary];
    }
    return NO;
}

- (NSArray *)executeQueryWithSQL:(void(^)(SQLTool<beginProtocolList> *tool))block {
    if (block) {
        SQLTool<beginProtocolList> *tool = [[SQLTool<beginProtocolList> alloc] init];
        block(tool);
        return [self getResultArrayFromFMResultSet:[database executeQuery:tool.SQLString]];
    }
    return NO;
}

- (NSArray *)getResultArrayFromFMResultSet:(FMResultSet *)resultSet {
    NSMutableArray *resultArray = [NSMutableArray array];
    while ([resultSet next]) {
        [resultArray addObject:[resultSet resultDictionary]];
    };
    return resultArray;
}
@end
