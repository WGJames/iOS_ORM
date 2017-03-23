//
//  DCValueTransformer+Addtional.h
//  DC_ORM
//
//  Created by James on 16/6/10.
//  Copyright © 2016年 James. All rights reserved.
//

#import "DCValueTransformer.h"
extern NSString * const DCNSStringToNSNumberTransformerName;
extern NSString * const DCNSNumberToNSStringTransformerName;

@interface DCValueTransformer (Addtional)
/**
 *  <#Description#>
 */
+ (void)dc_registerNSStringToNSNumberValueTransformer;
/**
 *  <#Description#>
 */
+ (void)dc_registerNSNumberToNSStringValueTransformer;

@end
