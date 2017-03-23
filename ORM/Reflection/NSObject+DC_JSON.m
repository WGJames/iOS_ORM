//
//  NSObject+DC_JSON.m
//  DC_ORM
//
//  Created by James on 16/5/29.
//  Copyright © 2016年 James. All rights reserved.
//

#import "NSObject+DC_JSON.h"
#import "NSObject+DC_Reflection.h"
#import "NSObject+DC_Properties.h"
#import "NSArray+Help.h"
#import "NSDictionary+Help.h"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
@implementation NSObject (DC_JSON)

+ (instancetype)dc_initObjectFromJsonDictionary:(NSDictionary *)jsonDictionary {
    NSObject *object = [[self alloc] init];
    [self dc_enumerateKeysAndClassNameUsingBlock:^(NSString *key, NSString *className, BOOL *stop) {
        SEL transformSEL = NSSelectorFromString(@"transformDictionary");
        NSString *targetKey = key;
        if ([self respondsToSelector:transformSEL]) {
            NSDictionary *transformDic = [self performSelector:transformSEL];
            NSString *tmpKey = [transformDic safty_objectForKey:key];
            targetKey = tmpKey ? tmpKey : key;
        }
        __autoreleasing id oldValue = [jsonDictionary safty_objectForKey:targetKey];
        if (oldValue == nil) {
            oldValue = [jsonDictionary safty_objectForKey:key];
        }
        NSString *selectorString = [NSString stringWithFormat:@"%@Transformer",key];
        SEL selector = NSSelectorFromString(selectorString);
        if ([self respondsToSelector:selector]) {
            NSValueTransformer *transformer = [self performSelector:selector];
            __autoreleasing id forwardValue = [transformer transformedValue:oldValue];
            [object dc_setValue:forwardValue forKey:key];
        } else {
            [object dc_setValue:oldValue forKey:key];
        }
    }];
    return object;
}

+ (NSArray *)dc_modelListFromDictionaryList:(NSArray *)dicList {
    NSMutableArray *resultList = [NSMutableArray array];
    for (NSInteger index = 0; index < dicList.count; index ++) {
        if ([dicList[index] isKindOfClass:[NSDictionary class]]) {
            __autoreleasing id forwardValue = [self dc_initObjectFromJsonDictionary:(NSDictionary *)dicList[index]];
            [resultList addObject:forwardValue];
        }
    }
    return resultList;
}

+ (instancetype)dc_initObjectFromJsonDictionary:(NSDictionary *)jsonDictionary KeyDictionary:(NSDictionary *)keyDictionary {
    NSObject *object = [[self alloc] init];
    [self dc_enumerateKeysAndClassNameUsingBlock:^(NSString *key, NSString *className, BOOL *stop) {
        NSString *jsonKey = [keyDictionary safty_objectForKey:key];
        NSString *valueKey = jsonKey ? jsonKey : key;
        __autoreleasing id oldValue = [jsonDictionary safty_objectForKey:valueKey];
        NSString *selectorString = [NSString stringWithFormat:@"%@Transformer",key];
        SEL selector = NSSelectorFromString(selectorString);
        if ([self respondsToSelector:selector]) {
            NSValueTransformer *transformer = [self performSelector:selector];
            __autoreleasing id forwardValue = [transformer transformedValue:oldValue];
            [object dc_setValue:forwardValue forKey:key];
        } else {
            [object dc_setValue:oldValue forKey:key];
        }
    }];
    return object;
}

+ (void)dc_updateValuesWithDictionary:(NSDictionary *)dic Object:(NSObject *)object {
    [self dc_enumerateKeysAndClassNameUsingBlock:^(NSString *key, NSString *className, BOOL *stop) {
        SEL transformSEL = NSSelectorFromString(@"transformDictionary");
        NSString *targetKey = key;
        if ([self respondsToSelector:transformSEL]) {
            NSDictionary *transformDic = [self performSelector:transformSEL];
            NSString *tmpKey = [transformDic safty_objectForKey:key];
            targetKey = tmpKey ? tmpKey : key;
        }
        __autoreleasing id oldValue = [dic safty_objectForKey:targetKey];
        NSString *selectorString = [NSString stringWithFormat:@"%@Transformer",key];
        SEL selector = NSSelectorFromString(selectorString);
        if ([self respondsToSelector:selector]) {
            NSValueTransformer *transformer = [self performSelector:selector];
            __autoreleasing id forwardValue = [transformer transformedValue:oldValue];
            [object dc_setValue:forwardValue forKey:key];
        } else {
            [object dc_setValue:oldValue forKey:key];
        }
    }];
}
@end
