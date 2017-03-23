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

+ (NSString *)makeSQL:(void(^)(SQLTool<beginProtocolList> *tool))block {
    if (block) {
        SQLTool<beginProtocolList> *tool = [[SQLTool<beginProtocolList> alloc] init];
        block(tool);
        return tool.sql;
    }
    return nil;
}
#pragma mark - block
- (OnlySQL)onlySQL {
    return ^(id sql) {
        if (validateParameterIsClass(sql, @"NSString")) {
            self.sql = sql;
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
                self.sql = [NSString stringWithFormat:@"SELECT %@",columnsString];
            } else {
                self.sql = @"SELECT *";
            }
        } else if (validateParameterIsClass(columns, @"NSString")) {
            self.sql = [NSString stringWithFormat:@"SELECT %@",columns];
        } else {
            NSLog(@"the select is invalid");
        }
        return self;
    };
}

- (Insert)insert {
    return nil;
}

- (Update)update {
    return ^(NSString *table, id valueList) {
        if (validateParameterIsClass(table, @"NSString")) {
            self.sql = [NSString stringWithFormat:@"UPDATE %@ SET ",table];
            if (validateParameterIsClass(valueList, @"NSString")) {
                NSString *valueString = [NSString stringWithFormat:@"%@",valueList];
                self.sql = [self.sql stringByAppendingString:valueString];
            } else if (validateParameterIsClass(valueList, @"NSArray")) {
                NSString *valueListString = [valueList componentsJoinedByString:@","];
                self.sql = [self.sql stringByAppendingString:valueListString];
            } else {
                NSLog(@"the update value list is invalid");
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
            self.sql = [self.sql stringByAppendingString:fromString];
        } else if (validateParameterIsClass(table, @"NSArray")){
            NSArray *tableList = [NSArray safty_arrayWithArray:table];
            NSString *tableListString = [tableList componentsJoinedByString:@","];
            self.sql = [self.sql stringByAppendingString:[NSString stringWithFormat:@" FROM %@",tableListString]];
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
            self.sql = [self.sql stringByAppendingString:[NSString stringWithFormat:@" ORDER BY %@",orderByString]];
        } else if (validateParameterIsClass(orderBys, @"NSString")){
            NSString *orderByString = [NSString stringWithFormat:@" ORDER BY %@",orderBys];
            self.sql = [self.sql stringByAppendingString:orderByString];
        } else {
            NSLog(@"the orderBy is invalid");
        }
        return self;
    };
 
}

- (Condition)condition {
    return ^(NSString *key, NSString *operate, NSString *value) {
        return self;
    };
}

- (WholeCondition)wholeCondition {
    return ^(NSString *condition) {
        if (validateParameterIsClass(condition, @"NSString")) {
            NSString *wholeCondition = [NSString stringWithFormat:@" %@",condition];
            self.sql = [self.sql stringByAppendingString:wholeCondition];
        } else {
            NSLog(@"the whole condition is invalid");
        }
        return self;
    };
}

#pragma mark -- SQLTool
- (SQLTool *)where {
    self.sql = [self.sql stringByAppendingString:@" WHERE"];
    return self;
}

- (SQLTool *)sql_delete {
    self.sql = @"DELETE";
    return self;
}

@end
