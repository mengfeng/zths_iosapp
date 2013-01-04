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
-(void) initialize_config;
-(BOOL) add_new_obj_to_server:(Dream *)data_obj;
-(BOOL) remove_object_from_server:(Dream *)data_obj;
-(BOOL) update_object_to_server:(Dream *)data_obj;
-(BOOL) send_request_server:(NSString *) url_string post_string:(NSString *) post_string;
@end

@interface DreamDataController()
{
    NSString *host_name;
    NSString *app_name;
    
}
@end

@implementation DreamDataController


-(id) init
{
    self=[super init];
    
    
    self.dreamlist=[[NSMutableArray alloc] init];
    
    [self initialize_config];
    return self;
    

}

-(void) initialize_config
{
    host_name=@"http://localhost:8081";
    //host_name=@"http://zinthedream.appspot.com";
    app_name=@"zdream";

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
    [self initialize_config];
    
    self.dreamlist=[[NSMutableArray alloc] init];
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/rpc?dispatcher=get_records&data_class=%@",host_name,data_class];
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
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/%@",host_name,app_name] ;
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=update_records&actionType=insert&author=%@&description=%@",data_obj.author,data_obj.content ];
        
    
    return [self send_request_server:url_string post_string:post_string];
}

-(void) remove_object_at_index:(NSInteger)index
{
    Dream* current_obj=[self object_at_index:index];
    if(current_obj){
        [self.dreamlist removeObjectAtIndex:index];
        [self remove_object_from_server:current_obj];
    }
    
}


-(BOOL) remove_object_from_server:(Dream *)data_obj
{
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/%@",host_name,app_name] ;
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=update_records&actionType=delete&record_key=%@",data_obj.instance_key];
    
    
    return [self send_request_server:url_string post_string:post_string];
}

-(void)update_object:(Dream *)data_obj current_index:(NSInteger)current_index
{
    
    Dream *current_data_obj=[self object_at_index:current_index];
    
    if(current_data_obj != data_obj)    current_data_obj.content=data_obj.content;
   
        
    [self update_object_to_server:data_obj];
    
}

-(BOOL) update_object_to_server:(Dream *)data_obj
{
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/%@",host_name,app_name] ;
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=update_records&actionType=update&record_key=%@&description=%@",data_obj.instance_key,data_obj.content];
    
    
    return [self send_request_server:url_string post_string:post_string];

}

-(BOOL) send_request_server:(NSString *)url_string post_string:(NSString *)post_string
{
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
