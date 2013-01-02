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
-(BOOL) add_new_obj_to_server:(Dream *)data_obj;
@end

@interface DreamDataController()
{

}
@end

@implementation DreamDataController


-(id) init
{
    self=[super init];
    
    
    self.dreamlist=[[NSMutableArray alloc] init];
    
    
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
    
    [self add_new_obj_to_server:data_obj];
}


-(id) init_data_from_remote_json:(NSString *)data_class
{
    self.dreamlist=[[NSMutableArray alloc] init];
    //NSString *url_string=[@"http://zinthedream.appspot.com/rpc?dispatcher=get_records&data_class=" stringByAppendingString:data_class];
    NSString *url_string=[@"http://localhost:8081/rpc?dispatcher=get_records&data_class=" stringByAppendingString:data_class];
    
    NSData *response_data=[NSMutableData data];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url_string]];
    
    NSURLResponse *response=nil;
    NSError *error=[[NSError alloc] init];
    
    response_data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSError *json_error=[[NSError alloc] init];
    NSDictionary *json_obj=[NSJSONSerialization JSONObjectWithData:response_data options:NSJSONReadingMutableContainers error:&json_error];
    
    if(json_obj){
        NSString *status=[json_obj objectForKey:@"status"];
        
        if([status isEqualToString:@"ok"]){
            
            NSArray *records=[json_obj objectForKey:@"records"];
            for(NSDictionary *current_record in records){
                
                
                NSString *current_author=[current_record objectForKey:@"author"];
                NSString *current_content=[current_record objectForKey:@"record_content"];
                
                NSString *current_title=[current_record objectForKey:@"record_title"];
                
                NSString *date_string=[current_record objectForKey:@"created"];
                NSDateFormatter *current_date_formater=[[NSDateFormatter alloc] init];
                [current_date_formater setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss 'GMT'"] ;
                NSDate *current_date=[current_date_formater dateFromString:date_string];
                NSString *current_instance_key=[current_record objectForKey:@"record_key"];
                NSString *current_email=[current_record objectForKey:@"email"];
                NSString *current_image_url=[current_record objectForKey:@"image_url"];
                NSString *current_image_key=@"";
                
                [self add_object_with_properties:current_author content:current_content image_url:current_image_url title:current_title email:current_email date:current_date instance_key:current_instance_key image_key:current_image_key];
                
                
                
            }
        }else{
            NSLog(@"JSON data contains error message: %@",[json_obj objectForKey:@"message"]);
            
        }
    }else{
        NSLog(@"Fail to fetch JSON data: %@", [json_error localizedDescription]);
    }
    return self;
    
}

-(BOOL) add_new_obj_to_server:(Dream *)data_obj
{
    //NSString *url_string=@"http://zinthedream.appspot.com/zdream";
    NSString *url_string=@"http:localhost:8081/zdream";
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=update_records&actionType=insert&author=%@&description=%@",data_obj.author,data_obj.content ];
    post_string=[post_string stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_string]];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[post_string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSHTTPURLResponse *response=nil;
    NSError *error=[[NSError alloc] init];
    NSData *response_data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *response_string=[[NSString alloc] initWithData:response_data encoding:NSUTF8StringEncoding];
    
    //NSLog(@"The response string is %@", response_string);
    return YES;
}


@end
