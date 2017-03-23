//
//  NSObject+DC_JSON.h
//  DC_ORM
//
//  Created by James on 16/5/29.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DC_JSON)
/**
 *  <#Description#>
 *
 *  @param jsonDictionary <#jsonDictionary description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)dc_initObjectFromJsonDictionary:(NSDictionary *)jsonDictionary;
/**
 *  <#Description#>
 *
 *  @param dicList <#dicList description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray *)dc_modelListFromDictionaryList:(NSArray *)dicList;
/**
 *  <#Description#>
 *
 *  @param jsonDictionary <#jsonDictionary description#>
 *  @param keyDictionary  <#keyDictionary description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)dc_initObjectFromJsonDictionary:(NSDictionary *)jsonDictionary KeyDictionary:(NSDictionary *)keyDictionary;
/**
 *  <#Description#>
 *
 *  @param dic    <#dic description#>
 *  @param object <#object description#>
 */
+ (void)dc_updateValuesWithDictionary:(NSDictionary *)dic Object:(NSObject *)object;
@end
