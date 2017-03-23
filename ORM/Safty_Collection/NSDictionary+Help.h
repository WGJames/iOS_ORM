//
//  NSDictionary+Help.h
//  NewProject
//
//  Created by JamesCheng on 2017/1/15.
//  Copyright © 2017年 CashBus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Help)
+ (instancetype)safty_dictionaryWithDictionary:(NSObject *)dictionary;
- (id)safty_objectForKey:(NSString *)key;
@end
