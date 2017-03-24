//
//  DatabaseManager.h
//  ORM
//
//  Created by JamesCheng on 2017/3/24.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface DatabaseManager : NSObject
+ (DatabaseManager *)sharedDatabaseManager;
@property (nonatomic, strong, readonly) FMDatabase *database;
@end
