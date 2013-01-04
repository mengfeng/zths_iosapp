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
                         image_url:(NSString *) image_url
                             title:(NSString *) title
                             email:(NSString *) email
                              date:(NSDate *) date
                      instance_key:(NSString *) instance_key
                         image_key:(NSString *) image_key;
-(void) add_object:(Dream *) data_obj;
-(void) add_object_at_head:(Dream *) data_obj;
-(id) init_data_from_remote_json:(NSString *)data_class;
-(void) remove_object_at_index:(NSInteger) index;
-(void) update_object:(Dream *) data_obj current_index:(NSInteger) current_index;

@end
