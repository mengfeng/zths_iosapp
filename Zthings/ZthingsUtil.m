//
//  ZthingsUtil.m
//  Zthings
//
//  Created by Feng on 30/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "ZthingsUtil.h"

@implementation ZthingsUtil

+(NSString *) replace_string_by_array:(NSString *)original_string strings_to_replace:(NSArray *)strings_to_replace with_string:(NSString *)with_string
{

    NSString *result_string=original_string;
    for(NSString *string_to_replace in strings_to_replace){
        
        result_string=[result_string stringByReplacingOccurrencesOfString:string_to_replace withString:with_string];
    }
    
    return result_string;
}

@end
