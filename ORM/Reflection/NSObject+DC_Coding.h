//
//  NSObject+DC_Coding.h
//  DC_ORM
//
//  Created by James on 16/5/28.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DC_Coding)

+ (void)dc_setClassCodingIngoredList:(NSArray *)ingoredList;

+ (void)dc_setClassCodingAllowedList:(NSArray *)allowedList;

- (void)dc_setObjectCodingIngoredList:(NSArray *)ingoredList;

- (void)dc_setObjectCodingAllowedList:(NSArray *)allowedList;

@end
