//
//  NSObject+SQLHelper.h
//  ORM
//
//  Created by JamesCheng on 2017/3/30.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
@interface NSObject (SQLHelper)
+ (void)createTableSQLOperation;
@end
