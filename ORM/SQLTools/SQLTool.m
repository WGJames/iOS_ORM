//
//  SQLTool.m
//  ORM
//
//  Created by 程成 on 2017/3/20.
//  Copyright © 2017年 程成. All rights reserved.
//

#import "SQLTool.h"
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
        if ([sql isKindOfClass:[NSString class]]) {
            
        } else {
            
        }
        return self;
    };
}

- (Select)select {
    return ^(NSArray<NSString *> *columns) {
        if (columns.count > 0) {
            NSString *columnsString = [columns componentsJoinedByString:@","];
            self.sql = [NSString stringWithFormat:@"SELECT %@ ",columnsString];
        } else {
            self.sql = @"SELECT * ";
        }
        return self;
    };
}

- (Insert)insert {
    return nil;
}

- (Update)update {
    return nil;
}

- (From)from {
    return ^(NSString *table) {
        if (table) {
            NSString *fromString = [NSString stringWithFormat:@"FROM %@ ",table];
            self.sql = [self.sql stringByAppendingString:fromString];
        }
        return self;
    };
}

- (OrderBy)orderBy {
    return nil;
}

- (Condition)condition {
    return ^(NSString *key, NSString *operate, NSString *value) {
        return self;
    };
}

- (WholeCondition)wholeCondition {
    return ^(NSString *condition) {
        return self;
    };
}

#pragma mark -- SQLTool
- (SQLTool *)where {
    return self;
}

- (SQLTool *)sql_delete {
    return self;
}

@end
