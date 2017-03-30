//
//  SQLTool.m
//  ORM
//
//  Created by 程成 on 2017/3/20.
//  Copyright © 2017年 程成. All rights reserved.
//

#import "SQLTool.h"
#import "NSArray+Help.h"
static inline BOOL validateParameterIsClass(id object, NSString *className) {
    if ([object isKindOfClass:NSClassFromString(className)]) {
        return YES;
    }
    return NO;
}

@interface SQLTool ()<selectProtocol,fromProtocol,whereProtocol,onlySQLProtocol,insertPotocol,updateProtocol,onlySQLProtocol,deleteProtocol,orderByProtocol,conditionProtocol,wholeConditionProtocol,deleteProtocol>
@end
@implementation SQLTool
@synthesize SQLString;

#pragma mark - block
- (OnlySQL)onlySQL {
    return ^(id sql) {
        if (validateParameterIsClass(sql, @"NSString")) {
            SQLString = sql;
        } else {
            NSLog(@"the only sql is invalid");
        }
        return self;
    };
}

- (Select)select {
    return ^(id columns) {
        if (validateParameterIsClass(columns, @"NSArray")) {
            NSArray *columnList = [NSArray safty_arrayWithArray:columns];
            if (columnList.count > 0) {
                NSString *columnsString = [columnList componentsJoinedByString:@","];
                SQLString = [NSString stringWithFormat:@"SELECT %@",columnsString];
            } else {
                SQLString = @"SELECT *";
            }
        } else if (validateParameterIsClass(columns, @"NSString")) {
            SQLString = [NSString stringWithFormat:@"SELECT %@",columns];
        } else {
            NSLog(@"the select is invalid");
        }
        return self;
    };
}

- (Insert)insert {
    return ^(NSString *table, NSArray *keyList) {
        if (validateParameterIsClass(table, @"NSString")) {
            if (validateParameterIsClass(keyList, @"NSArray")) {
                NSString *keyString = [keyList componentsJoinedByString:@", "];
                NSString *valueString = [keyList componentsJoinedByString:@", :"];
                valueString = [NSString stringWithFormat:@":%@",valueString];
                SQLString = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",table,keyString,valueString];
            } else {
                NSLog(@"the insert key list is invalid");
            }
        } else {
            NSLog(@"the insert table is invalid");
        }
        return self;
    };
}

- (Update)update {
    return ^(NSString *table, NSArray *keyList) {
        if (validateParameterIsClass(table, @"NSString")) {
            if (validateParameterIsClass(keyList, @"NSArray")) {
                NSString *keyString = [keyList componentsJoinedByString:@" = ?,"];
                NSString *updateString = [NSString stringWithFormat:@"%@ = ?",keyString];
                SQLString = [NSString stringWithFormat:@"UPDATE %@ SET %@",table,updateString];
            } else {
                NSLog(@"the insert key list or value list is invalid");
            }
        } else {
            NSLog(@"the update table is invalid");
        }
        return self;
    };
}

- (From)from {
    return ^(id table) {
        if (validateParameterIsClass(table, @"NSString")) {
            NSString *fromString = [NSString stringWithFormat:@" FROM %@",table];
            SQLString = [SQLString stringByAppendingString:fromString];
        } else if (validateParameterIsClass(table, @"NSArray")){
            NSArray *tableList = [NSArray safty_arrayWithArray:table];
            NSString *tableListString = [tableList componentsJoinedByString:@","];
            SQLString = [SQLString stringByAppendingString:[NSString stringWithFormat:@" FROM %@",tableListString]];
        } else {
            NSLog(@"the from is invalid");
        }
        return self;
    };
}

- (OrderBy)orderBy {
    return ^(id orderBys) {
        if (validateParameterIsClass(orderBys, @"NSArray")) {
            NSArray *orderByList = [NSArray safty_arrayWithArray:orderBys];
            NSString *orderByString = [orderByList componentsJoinedByString:@","];
            SQLString = [SQLString stringByAppendingString:[NSString stringWithFormat:@" ORDER BY %@",orderByString]];
        } else if (validateParameterIsClass(orderBys, @"NSString")){
            NSString *orderByString = [NSString stringWithFormat:@" ORDER BY %@",orderBys];
            SQLString = [SQLString stringByAppendingString:orderByString];
        } else {
            NSLog(@"the orderBy is invalid");
        }
        return self;
    };
 
}

- (Condition)condition {
    return ^(NSString *key, NSString *operate, NSString *value) {
        NSString *conditionSQL = [NSString stringWithFormat:@" %@ %@ %@",key,operate,value];
        SQLString = [SQLString stringByAppendingString:conditionSQL];
        return self;
    };
}

- (WholeCondition)wholeCondition {
    return ^(NSString *condition) {
        if (validateParameterIsClass(condition, @"NSString")) {
            NSString *wholeCondition = [NSString stringWithFormat:@" %@",condition];
            SQLString = [SQLString stringByAppendingString:wholeCondition];
        } else {
            NSLog(@"the whole condition is invalid");
        }
        return self;
    };
}

#pragma mark -- SQLTool
- (SQLTool *)where {
    SQLString = [SQLString stringByAppendingString:@" WHERE"];
    return self;
}

- (SQLTool *)sql_delete {
    SQLString = @"DELETE";
    return self;
}

@end
