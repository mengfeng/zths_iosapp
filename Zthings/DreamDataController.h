//
//  DreamDataController.h
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dream;

@interface DreamDataController : NSObject
@property (nonatomic) NSMutableArray *dreamlist;
-(NSInteger) count_of_dreams;
-(Dream *) object_at_index:(NSInteger) index;
-(void) add_object_with_properties:(NSString *) author
                           content:(NSString *) content
                             email:(NSString *) email
                              date:(NSDate *) date
                      instance_key:(NSString *) instance_key;


@end
