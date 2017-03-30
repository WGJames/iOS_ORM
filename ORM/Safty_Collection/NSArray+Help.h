//
//  NSArray+Help.h
//  NewProject
//
//  Created by JamesCheng on 2016/10/11.
//  Copyright © 2016年 CashBus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Help)
- (id)safty_objectAtIndex:(NSUInteger)index;

+ (instancetype)safty_arrayWithArray:(NSObject *)array;

- (NSArray *)getValueListFromDictionaryListWithKey:(NSString *)key;
@end
