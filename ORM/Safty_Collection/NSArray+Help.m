//
//  NSArray+Help.m
//  NewProject
//
//  Created by JamesCheng on 2016/10/11.
//  Copyright © 2016年 CashBus. All rights reserved.
//

#import "NSArray+Help.h"

@implementation NSArray (Help)
- (id)safty_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [[self objectAtIndex:index] isEqual:[NSNull null]] ? nil : [self objectAtIndex:index];
    }
    return nil;
}

+ (instancetype)safty_arrayWithArray:(NSObject *)array {
    if ([array isKindOfClass:[NSArray class]]) {
        return [self arrayWithArray:(NSArray *)array];
    } else {
        return [self array];
    }
}
@end
