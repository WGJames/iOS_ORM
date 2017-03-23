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
        [SQLTool makeSQL:^(SQLTool<beginProtocolList> *tool) {
            tool.select(@[@"",@""]).from(@"123").where.wholeCondition(@"");
            NSLog(@"%@",tool.sql);
        }];
    }
    return 0;
}
