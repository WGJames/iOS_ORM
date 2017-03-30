//
//  main.m
//  ORM
//
//  Created by JamesCheng on 2017/3/23.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "NSArray+Help.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        [[DatabaseManager sharedDatabaseManager] initDatabaseWithFileName:@"test"];
        [[DatabaseManager sharedDatabaseManager] executeQueryWithSQL:^(SQLTool<beginProtocolList> *tool) {
            tool.select(@"*").from(@"user").where.condition(@"userId",@"=",@"123232");
            NSLog(@"%@",tool.SQLString);
        }];
    }
    return 0;
}
