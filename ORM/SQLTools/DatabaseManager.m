//
//  DatabaseManager.m
//  ORM
//
//  Created by JamesCheng on 2017/3/24.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import "DatabaseManager.h"
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
    database = [FMDatabase databaseWithPath:filePath];
}

- (void)openDatabase {
    if ([database open]) {
        [database setDateFormat:[FMDatabase storeableDateFormat:NSDATE_DEFAULT_FORMART]];
    } else {
        NSLog(@"the database couldn't open!");
    }
}

- (void)closeDatabase {
    if (![database close]) {
        NSLog(@"the database couldn't close!");
    }
}

- (BOOL)executeUpdateWithSQLString:(NSString *)SQLString {
    return [database executeUpdate:SQLString];
}

- (FMResultSet *)executeQueryWithSQLString:(NSString *)SQLString {
    return [database executeQuery:SQLString];
}

- (BOOL)executeUpdateWithSQLString:(NSString *)SQLString Dictionary:(NSDictionary *)dictionary {
    return [database executeUpdate:SQLString withParameterDictionary:dictionary];
}

- (BOOL)executeUpdateWithSQLString:(NSString *)SQLString Array:(NSArray *)array {
    return [database executeUpdate:SQLString withArgumentsInArray:array];
}

@end
