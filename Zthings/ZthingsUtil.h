//
//  ZthingsUtil.h
//  Zthings
//
//  Created by Feng on 30/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZthingsUtil : NSObject

+(NSString *) replace_string_by_array: (NSString *) original_string
                   strings_to_replace:(NSArray *) strings_to_replace
                          with_string:(NSString *) with_string;

@end
