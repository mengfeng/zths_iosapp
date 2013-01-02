//
//  DreamDataController.m
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "DreamDataController.h"
#import "Dream.h"


@interface DreamDataController()
{
    NSString *url_string;
    NSMutableData *response_data;
}
@end

@implementation DreamDataController
//@synthesize dreamlist=_dreamlist;


-(id) init
{
    self=[super init];
    
    if(!self.dreamlist){
        self.dreamlist=[[NSMutableArray alloc] init];
    }
    
    return self;
    

}


-(NSInteger) count_of_dreams
{
    return [self.dreamlist count];
}
-(void) setDreamlist:(NSArray *)dreamlist
{
    _dreamlist=[dreamlist mutableCopy];
}

-(Dream *) object_at_index:(NSInteger )index
{
    return [self.dreamlist objectAtIndex:index];
}

-(void) add_object_with_properties:(NSString *)author content:(NSString *)content image_url:(NSString *)image_url title:(NSString *)title email:(NSString *)email date:(NSDate *)date instance_key:(NSString *)instance_key image_key:(NSString *)image_key
{
    
    
    Dream *new_dream=[[Dream alloc] init_with_properties:author content:content image_url:image_url title:title email:email date:date instance_key:instance_key image_key:image_key];
    [self.dreamlist addObject:new_dream];
    
}

-(void) add_object:(Dream *)data_obj
{
    [self.dreamlist addObject:data_obj];
}

-(void) add_object_at_head:(Dream *)data_obj
{
    if([self count_of_dreams]==0) [self add_object:data_obj];
    else   [self.dreamlist insertObject:data_obj atIndex:0];
}





@end
