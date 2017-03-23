//
//  NSDictionary+Help.m
//  NewProject
//
//  Created by JamesCheng on 2017/1/15.
//  Copyright © 2017年 CashBus. All rights reserved.
//

#import "NSDictionary+Help.h"

@implementation NSDictionary (Help)
+ (instancetype)safty_dictionaryWithDictionary:(NSObject *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return [self dictionaryWithDictionary:(NSDictionary *)dictionary];
    } else {
        return [self dictionary];
    }
}

- (id)safty_objectForKey:(NSString *)key {
    id object = [self objectForKey:key];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
