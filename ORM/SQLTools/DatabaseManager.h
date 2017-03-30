//
//  DatabaseManager.h
//  ORM
//
//  Created by JamesCheng on 2017/3/24.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+SQLHelper.h"
#import "SQLTool.h"
#import "FMDB.h"
@interface DatabaseManager : NSObject
+ (DatabaseManager *)sharedDatabaseManager;
@property (nonatomic, strong, readonly) FMDatabase *database;

- (void)initDatabaseWithFileName:(NSString *)fileName;

- (void)openCurrentDatabase;

- (void)closeCurrentDatabase;

- (BOOL)executeUpdateWithSQL:(void(^)(SQLTool<beginProtocolList> *tool))block;

- (BOOL)executeUpdateWithSQL:(void(^)(SQLTool<beginProtocolList> *tool))block Array:(NSArray *)array;

- (BOOL)executeUpdateWithSQL:(void(^)(SQLTool<beginProtocolList> *tool))block Dictionary:(NSDictionary *)dictionary;

- (NSArray *)executeQueryWithSQL:(void(^)(SQLTool<beginProtocolList> *tool))block;
@end
