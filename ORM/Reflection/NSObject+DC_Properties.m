//
//  NSObject+DC_Properties.m
//  DC_ORM
//
//  Created by James on 16/5/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import "NSObject+DC_Properties.h"
#import "NSArray+Help.h"
#import "NSDictionary+Help.h"
#import <objc/runtime.h>

@implementation NSObject (DC_Properties)

static void *DCPropertiesDictionary = (void *)@"DCPropertiesDictionary";
static void *DCBasicTypesDictionary = (void *)@"DCBasicTypesDictionary";

+ (NSDictionary *)dc_propertiesDetailDictionary {
    NSDictionary *propertiesDetailDictionary = objc_getAssociatedObject(self, DCPropertiesDictionary);
    if (propertiesDetailDictionary == nil) {
        NSMutableDictionary *propertyDictionary = [NSMutableDictionary dictionary];
        [self dc_enumeratePropertiesUsingBlock:^(objc_property_t property, BOOL *stop) {
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            char *attributeValue = property_copyAttributeValue(property,"T");
            NSString *propertyClassName = [self dc_getPropertyClassNameWithAttributeValue:attributeValue];
            [propertyDictionary setValue:propertyClassName forKey:propertyName];
            free(attributeValue);
        }];
        objc_setAssociatedObject(self, DCPropertiesDictionary, propertyDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return propertyDictionary;
    } else {
        return propertiesDetailDictionary;
    }
}

+ (NSString *)dc_getPropertyClassNameWithAttributeValue:(const char *)attributeValue {
    NSString *className = [NSString stringWithUTF8String:attributeValue];
    if ([className containsString:@"@"]) {
        className = [self dc_getIdClassNameWithAttributeName:className];
    } else {
        className = [self dc_getBasicTypeNameWithAttributeName:className];
    }
    return className;
}

+ (void)dc_enumeratePropertiesUsingBlock:(void (^)(objc_property_t property, BOOL *stop))propertyBlock {
    unsigned int count;
    BOOL isStop = NO;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        if (propertyBlock) {
            propertyBlock(properties[i],&isStop);
        }
        if (isStop) break;
    }
    free(properties);
}

+ (void)dc_enumerateKeysAndClassNameUsingBlock:(void (^)(NSString *key, NSString *className, BOOL *stop))keyBlock {
    BOOL isStop = NO;
    NSDictionary *propertiesDictionary = [self dc_propertiesDetailDictionary];
    for (NSString *key in propertiesDictionary.allKeys) {
        if (keyBlock) {
            NSString *className = [propertiesDictionary safty_objectForKey:key];
            keyBlock(key,className,&isStop);
        }
        if (isStop) break;
    }
}

+ (NSString *)dc_getIdClassNameWithAttributeName:(NSString *)attributeName {
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"@\""];
    NSString *className = [[attributeName componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@""];
    if ([className isEqualToString:@""]) {
        className = @"id";
    }
    return className;
}

+ (NSString *)dc_getBasicTypeNameWithAttributeName:(NSString *)attributeName {
    attributeName = [attributeName lowercaseString];
    NSString *className = [[self dc_BasicTypesDictionary] safty_objectForKey:attributeName];
    if (className == nil) {
        className = attributeName;
    }
    return className;
}

+ (NSDictionary *)dc_BasicTypesDictionary {
    NSDictionary *typesDictionary = objc_getAssociatedObject(self, DCBasicTypesDictionary);
    if (typesDictionary == nil) {
        NSArray *attributeArray = @[@"i",@"s",@"f",@"d",@"q",@"c",@"b"];
        NSArray *typesArray = @[@"int",@"short",@"float",@"double",@"long",@"char",@"BOOL"];
        NSDictionary *basicTypesDictionary = [NSDictionary dictionaryWithObjects:typesArray forKeys:attributeArray];
        objc_setAssociatedObject(self, DCBasicTypesDictionary, basicTypesDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return basicTypesDictionary;
    } else {
        return typesDictionary;
    }
}

+ (BOOL)dc_validateClassIsBasicType:(NSString *)className {
    NSArray *classList = [self dc_BasicTypesDictionary].allValues;
    return [classList containsObject:className];
}
@end
