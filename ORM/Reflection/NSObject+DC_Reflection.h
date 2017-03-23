//
//  NSObject+DC_Reflection.h
//  DC_ORM
//
//  Created by James on 16/5/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DC_Reflection)
/**
 *  <#Description#>
 *
 *  @param dictionary <#dictionary description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)dc_initObjectFromDictionary:(NSDictionary *)dictionary;
/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)dc_convertToDictionaryFromModel;
/**
 *  <#Description#>
 *
 *  @param keyList <#keyList description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)dc_convertToDictionaryFromModelWithKeyList:(NSArray *)keyList;
/**
 *  <#Description#>
 *
 *  @param keyList <#keyList description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)dc_getValueListWithKeyList:(NSArray *)keyList;
/**
 *  <#Description#>
 *
 *  @param value <#value description#>
 *  @param key   <#key description#>
 */
- (void)dc_setValue:(id)value forKey:(NSString *)key;
/**
 *  <#Description#>
 *
 *  @param dicList   <#dicList description#>
 *  @param className <#className description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)dc_modelListFromDictionaryList:(NSArray *)dicList ForwardClassName:(NSString *)className;

@end
