//
//  User.m
//  ORM
//
//  Created by JamesCheng on 2017/3/30.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import "User.h"

@implementation User
+ (NSString *)createTableSQLString {
    return @"CREATE ";
}

+ (NSString *)alterTableSQLString {
    return @"";
}

+ (NSString *)SQLTableName {
    return @"UserTable";
}


@end
