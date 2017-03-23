//
//  NSObject+DC_Properties.h
//  DC_ORM
//
//  Created by James on 16/5/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DC_Properties)
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)dc_propertiesDetailDictionary;
/**
 *  <#Description#>
 *
 *  @param keyBlock <#keyBlock description#>
 */
+ (void)dc_enumerateKeysAndClassNameUsingBlock:(void (^)(NSString *key, NSString *className, BOOL *stop))keyBlock;
/**
 *  <#Description#>
 *
 *  @param className <#className description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)dc_validateClassIsBasicType:(NSString *)className;

@end
