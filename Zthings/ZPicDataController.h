//
//  ZPicDataController.h
//  Zthings
//
//  Created by Feng Meng on 4/1/13.
//  Copyright (c) 2013 Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Update_Item_Delegate.h"
@class ZPic;
@interface ZPicDataController : NSObject <Update_Item_Delegate>
@property (nonatomic) NSMutableArray *obj_list;

-(NSInteger) count_of_objects;
-(ZPic *) object_at_index:(NSInteger) index;
-(void) add_object_with_properties:(NSString *) author
                           content:(NSString *) content
                         image_url:(NSString *) image_url
                             title:(NSString *) title
                             email:(NSString *) email
                              date:(NSDate *) date
                      instance_key:(NSString *) instance_key
                         image_key:(NSString *) image_key;
-(void) add_object:(ZPic *) data_obj;
-(void) add_object_at_head:(ZPic *) data_obj;
-(void) add_object_at_head_with_image:(ZPic *) data_obj image:(UIImage *) image;
-(id) init_data_from_remote_json:(NSString *)data_class;
-(void) remove_object_at_index:(NSInteger) index;
-(void) update_object:(ZPic *) data_obj current_index:(NSInteger) current_index;

@end
