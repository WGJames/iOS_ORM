//
//  DCValueTransformer.h
//  DC_ORM
//
//  Created by James on 16/6/10.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^DCValueTransformerBlock)(id value, BOOL *success, NSError **error);

@interface DCValueTransformer : NSValueTransformer
/**
 *  <#Description#>
 *
 *  @param forwardBlock <#forwardBlock description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)transformerUsingForwardBlock:(DCValueTransformerBlock)forwardBlock;
/**
 *  <#Description#>
 *
 *  @param reverseBlock <#reverseBlock description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)transformerUsingReverseBlock:(DCValueTransformerBlock)reverseBlock;
/**
 *  <#Description#>
 *
 *  @param forwardBlock <#forwardBlock description#>
 *  @param reverseBlock <#reverseBlock description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)transformerUsingForwardBlock:(DCValueTransformerBlock)forwardBlock ReverseBlock:(DCValueTransformerBlock)reverseBlock;

@end
