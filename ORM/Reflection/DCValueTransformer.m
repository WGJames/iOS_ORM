//
//  DCValueTransformer.m
//  DC_ORM
//
//  Created by James on 16/6/10.
//  Copyright © 2016年 James. All rights reserved.
//

#import "DCValueTransformer.h"
@interface DCValueTransformer ()
@property (nonatomic, copy) DCValueTransformerBlock forwardBlock;
@property (nonatomic, copy) DCValueTransformerBlock reverseBlock;
@end
@implementation DCValueTransformer

+ (instancetype)transformerUsingForwardBlock:(DCValueTransformerBlock)forwardBlock {
    return [[self alloc] initWithForwardBlock:forwardBlock ReverseBlock:nil];
}

+ (instancetype)transformerUsingReverseBlock:(DCValueTransformerBlock)reverseBlock {
    return [[self alloc] initWithForwardBlock:reverseBlock ReverseBlock:reverseBlock];
}

+ (instancetype)transformerUsingForwardBlock:(DCValueTransformerBlock)forwardBlock ReverseBlock:(DCValueTransformerBlock)reverseBlock {
    return [[self alloc] initWithForwardBlock:forwardBlock ReverseBlock:reverseBlock];
}

- (instancetype)initWithForwardBlock:(DCValueTransformerBlock)forwardBlock ReverseBlock:(DCValueTransformerBlock)reverseBlock {
    NSParameterAssert(forwardBlock != nil);
    self = [super init];
    if (self) {
        self.forwardBlock = forwardBlock;
        self.reverseBlock = reverseBlock;
    }
    return self;
}

- (id)transformedValue:(id)value {
    NSParameterAssert(self.forwardBlock != nil);
    NSError *error = nil;
    BOOL success = YES;
    if (value && ![value isEqual:[NSNull null]]) {
        return self.forwardBlock(value, &success, &error);
    } else {
        return nil;
    }
}

- (id)transformedValue:(id)value Success:(BOOL *)outSuccess Error:(NSError **)outError {
    NSError *error = nil;
    BOOL success = YES;
    id transformedValue = self.forwardBlock(value, &success, &error);
    if (outSuccess != NULL) {
        *outSuccess = success;
    }
    if (outError != NULL) {
        *outError = error;
    }
    return transformedValue;
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (Class)transformedValueClass {
    return [NSObject class];
}
@end

@interface DCReverseValueTransformer :DCValueTransformer

@end

@implementation DCReverseValueTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)reverseTransformedValue:(id)value {
    NSError *error = nil;
    BOOL success = YES;
    if (value && ![value isEqual:[NSNull null]]) {
        return self.reverseBlock(value, &success, &error);
    } else {
        return nil;
    }
}

- (id)reverseTransformedValue:(id)value Success:(BOOL *)outerSuccess Error:(NSError **)outerError {
    NSError *error = nil;
    BOOL success = YES;
    
    id transformedValue = self.reverseBlock(value, &success, &error);
    if (outerSuccess != NULL) {
        *outerSuccess = success;
    }
    if (outerError != NULL) {
        *outerError = error;
    }
    return transformedValue;
}

@end



