//
//  SQLTool.h
//  ORM
//
//  Created by 程成 on 2017/3/20.
//  Copyright © 2017年 程成. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SQLTool;
@protocol onlySQLProtocol;
@protocol selectProtocol,insertPotocol,updateProtocol,deleteProtocol;
@protocol fromProtocol,whereProtocol,orderByProtocol;

typedef SQLTool *(^OnlySQL)(id sql);
typedef SQLTool <fromProtocol> *(^Select)(id columns);
typedef SQLTool <whereProtocol, orderByProtocol>*(^From)(id table);
typedef SQLTool <whereProtocol>*(^Update)(NSString *tableName, NSArray *keyList);

typedef SQLTool <orderByProtocol>*(^Condition)(NSString *key, NSString *operate, NSString *value);
typedef SQLTool <orderByProtocol>*(^WholeCondition)(NSString *condition);
typedef SQLTool *(^OrderBy)(id orderBys);
typedef SQLTool *(^Insert)(NSString *tableName, NSArray *keyList);

#pragma mark -- block
@protocol beginProtocolList <selectProtocol, updateProtocol, insertPotocol, deleteProtocol, onlySQLProtocol>
@end

@protocol onlySQLProtocol <NSObject>
@property (nonatomic, copy, readonly) OnlySQL onlySQL;
@end

@protocol selectProtocol <NSObject>
@property (nonatomic, copy, readonly) Select select;
@end

@protocol fromProtocol <NSObject>
@property (nonatomic, copy, readonly) From from;
@end

@protocol orderByProtocol <NSObject>
@property (nonatomic, copy, readonly) OrderBy orderBy;
@end

@protocol conditionProtocol <NSObject>
@property (nonatomic, copy, readonly) Condition condition;
@end

@protocol wholeConditionProtocol <NSObject>
@property (nonatomic, copy, readonly) WholeCondition wholeCondition;
@end

@protocol insertPotocol <NSObject>
@property (nonatomic, copy, readonly) Insert insert;
@end

@protocol updateProtocol <NSObject>
@property (nonatomic, copy, readonly) Update update;
@end

#pragma mark -- SQLTool
@protocol whereProtocol <NSObject>
@property (nonatomic, strong, readonly) SQLTool<conditionProtocol,wholeConditionProtocol,orderByProtocol> *where;
@end

@protocol deleteProtocol <NSObject>
@property (nonatomic, strong, readonly) SQLTool<fromProtocol> *sql_delete;
@end

#pragma mark -- interface
@interface SQLTool : NSObject
+ (NSString *)makeSQL:(void(^)(SQLTool<beginProtocolList> *tool))block;
@property (nonatomic, strong) NSString *sql;
@end
