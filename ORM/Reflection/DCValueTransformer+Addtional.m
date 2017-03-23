//
//  DCValueTransformer+Addtional.m
//  DC_ORM
//
//  Created by James on 16/6/10.
//  Copyright © 2016年 James. All rights reserved.
//

#import "DCValueTransformer+Addtional.h"

NSString * const DCNSStringToNSNumberTransformerName = @"DCNSStringToNSNumberTransformer";
NSString * const DCNSNumberToNSStringTransformerName = @"DCNSNumberToNSStringTransformer";

@implementation DCValueTransformer (Addtional)
+ (void)dc_registerNSStringToNSNumberValueTransformer {
    DCValueTransformer *valueTransformer = [DCValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter numberFromString:value];
    } ReverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    }];
    [NSValueTransformer setValueTransformer:valueTransformer forName:DCNSStringToNSNumberTransformerName];
}

+ (void)dc_registerNSNumberToNSStringValueTransformer {
    DCValueTransformer *valueTransformer = [DCValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@",value];
    } ReverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter numberFromString:value];
    }];
    [NSValueTransformer setValueTransformer:valueTransformer forName:DCNSNumberToNSStringTransformerName];
}

@end
