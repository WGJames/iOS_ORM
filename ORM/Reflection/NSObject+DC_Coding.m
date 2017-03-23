//
//  NSObject+DC_Coding.m
//  DC_ORM
//
//  Created by James on 16/5/28.
//  Copyright © 2016年 James. All rights reserved.
//

#import "NSObject+DC_Coding.h"
#import "NSObject+DC_Properties.h"

@implementation NSObject (DC_Coding)
+ (void)dc_setClassCodingIngoredList:(NSArray *)ingoredList {
    
}

+ (void)dc_setClassCodingAllowedList:(NSArray *)allowedList {
    
}

- (void)dc_setObjectCodingIngoredList:(NSArray *)ingoredList {
    
}

- (void)dc_setObjectCodingAllowedList:(NSArray *)allowedList {
    
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    NSObject *object = [self init];
    if (object) {
        [[self class] dc_enumerateKeysAndClassNameUsingBlock:^(NSString *key, NSString *className, BOOL *stop) {
            id value = [decoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }];
    }
    return object;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [[self class] dc_enumerateKeysAndClassNameUsingBlock:^(NSString *key, NSString *className, BOOL *stop) {
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }];
}


@end
