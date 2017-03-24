//
//  main.m
//  ORM
//
//  Created by JamesCheng on 2017/3/23.
//  Copyright © 2017年 Molue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLTool.h"
#import "FMDB.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *result = [SQLTool makeSQL:^(SQLTool<beginProtocolList> *tool) {
            tool.select(@"userId").from(@"user").where.wholeCondition(@"userId = 1234").orderBy(@[@"userName DESC, class ASC"]);
            NSLog(@"operate sql = %@",tool.sql);
            tool.insert(@"user",@[@"userId",@"userName"]);
            NSLog(@"operate sql = %@",tool.sql);
            tool.update(@"user",@[@"userId",@"userName"]).where.wholeCondition(@"userId = 1234");
            NSLog(@"operate sql = %@",tool.sql);
        }];
        NSLog(@"result = %@",result);
    }
    return 0;
}
