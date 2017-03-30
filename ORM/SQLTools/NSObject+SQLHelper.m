//
//  NSObject+SQLHelper.m
//  ORM
//
//  Created by JamesCheng on 2017/3/30.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import "NSObject+SQLHelper.h"
#import "NSArray+Help.h"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
@implementation NSObject (SQLHelper)
+ (void)createTableSQLOperation {
    SEL targetSEL = NSSelectorFromString(@"createTableSQLString");
    if ([self respondsToSelector:targetSEL]) {
        NSString *createTableSQL = (NSString *)[self performSelector:targetSEL];
        [[DatabaseManager sharedDatabaseManager] executeUpdateWithSQL:^(SQLTool<beginProtocolList> *tool) {
            tool.onlySQL(createTableSQL);
        }];
    }
    [self alterTableSQLOperation];
}

+ (void)alterTableSQLOperation {
    
}

+ (NSString *)modelTableName {
    NSString *tableName = NSStringFromClass([self class]);
    SEL targetSEL = NSSelectorFromString(@"SQLTableName");
    if ([self respondsToSelector:targetSEL]) {
        tableName = (NSString *)[self performSelector:targetSEL];
    }
    return tableName;
}

+ (NSArray *)getColumnListFromTableName {
    NSString *SQLString = [NSString stringWithFormat:@"PRAGMA table_info([%@])",[self modelTableName]];
    NSArray *resultList = [[DatabaseManager sharedDatabaseManager] executeQueryWithSQL:^(SQLTool<beginProtocolList> *tool) {
        tool.onlySQL(SQLString);
    }];
    return [resultList getValueListFromDictionaryListWithKey:@"name"];
}
@end
