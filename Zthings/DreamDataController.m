//
//  DreamDataController.m
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "DreamDataController.h"
#import "Dream.h"

@implementation DreamDataController

-(NSInteger) count_of_dreams
{
    return [self.dreamlist count];
};

-(Dream *) object_at_index:(NSInteger )index
{
    return [self.dreamlist objectAtIndex:index];
};

-(void) add_object_with_properties:(NSString *)author content:(NSString *)content email:(NSString *)email date:(NSDate *)date instance_key:(NSString *) instance_key
{

    Dream *new_dream=[[Dream alloc] init_with_properties:author content:content email:email date:date instance_key:instance_key];
    [self.dreamlist addObject:new_dream];
    
};

@end
