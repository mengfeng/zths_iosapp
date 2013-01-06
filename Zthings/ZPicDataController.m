//
//  ZPicDataController.m
//  Zthings
//
//  Created by Feng Meng on 4/1/13.
//  Copyright (c) 2013 Z. All rights reserved.
//

#import "ZPicDataController.h"
#import "ZPic.h"
@interface ZPicDataController()
-(void) initialize_config;
-(BOOL) add_new_obj_to_server:(ZPic *)data_obj;
-(BOOL) remove_object_from_server:(ZPic *)data_obj;
-(BOOL) update_object_to_server:(ZPic *)data_obj;
-(NSString *) send_request_server:(NSString *) url_string post_string:(NSString *) post_string;
-(NSDictionary *) upload_image_to_server:(UIImage *) image;
-(NSString *)get_upload_url;
@end

@interface ZPicDataController()
{
    NSString *host_name;
    NSString *app_name;
}
@end

@implementation ZPicDataController

-(id) init
{
    self=[super init];
    
    
    self.obj_list=[[NSMutableArray alloc] init];
    
    [self initialize_config];
    return self;
    
    
}

-(void) initialize_config
{
    host_name=@"http://localhost:8081";
    //host_name=@"http://zinthedream.appspot.com";
    app_name=@"zpic";
    
}


-(NSInteger) count_of_objects
{
    return [self.obj_list count];
}
-(void) setObj_list:(NSMutableArray *)obj_list
{
    _obj_list=[obj_list mutableCopy];
}

-(ZPic *)object_at_index:(NSInteger)index
{
    return [self.obj_list objectAtIndex:index];
}

-(void) add_object_with_properties:(NSString *)author content:(NSString *)content image_url:(NSString *)image_url title:(NSString *)title email:(NSString *)email date:(NSDate *)date instance_key:(NSString *)instance_key image_key:(NSString *)image_key
{
    ZPic *new_obj=[[ZPic alloc] init_with_properties:author content:content image_url:image_url title:title email:email date:date instance_key:instance_key image_key:image_key];
    [self add_object:new_obj];
    
}

-(void) add_object:(ZPic *)data_obj
{
    [self.obj_list addObject:data_obj];
}


-(void) add_object_at_head:(ZPic *)data_obj
{
    if([self count_of_objects]==0) [self add_object:data_obj];
    else   [self.obj_list insertObject:data_obj atIndex:0];
    
    [self add_new_obj_to_server:data_obj];
}

-(void) add_object_at_head_with_image:(ZPic *)data_obj image:(UIImage *)image
{
    NSDictionary *dict_info=[self upload_image_to_server:image];
    data_obj.image_url=[dict_info objectForKey:@"image_url"];
    data_obj.instance_key=[dict_info objectForKey:@"new_record_key"];
    [self.obj_list insertObject:data_obj atIndex:0];
    [self update_object:data_obj current_index:0];
}

-(NSDictionary *) upload_image_to_server:(UIImage *)image
{
    NSString * upload_url=[self get_upload_url];
    if(![upload_url isEqualToString:@""]){
    
    }
}

-(id) init_data_from_remote_json:(NSString *)data_class
{
    [self initialize_config];
    
    self.obj_list=[[NSMutableArray alloc] init];
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/rpc",host_name];
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=get_records&data_class=%@",data_class];
    
    NSString *response_string=@"";
    response_string= [self send_request_server:url_string post_string:post_string];
    NSError *json_error=[[NSError alloc] init];
    NSDictionary *json_obj=[NSJSONSerialization JSONObjectWithData:[response_string dataUsingEncoding:NSUTF8StringEncoding]  options:NSJSONReadingMutableContainers error:&json_error];
    
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

-(BOOL) add_new_obj_to_server:(ZPic *)data_obj
{
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/%@",host_name,app_name] ;
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=update_records&actionType=insert&author=%@&description=%@",data_obj.author,data_obj.content ];
    
    
    [self send_request_server:url_string post_string:post_string];
    return YES;
}

-(void) remove_object_at_index:(NSInteger)index
{
    ZPic * current_obj=[self object_at_index:index];
    if(current_obj){
        [self.obj_list removeObjectAtIndex:index];
        [self remove_object_from_server:current_obj];
    }
    
}


-(BOOL) remove_object_from_server:(ZPic *)data_obj
{
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/%@",host_name,app_name] ;
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=update_records&actionType=delete&record_key=%@",data_obj.instance_key];
    
    
    [self send_request_server:url_string post_string:post_string];
    return YES;
}

-(void)update_object:(ZPic *)data_obj current_index:(NSInteger)current_index
{
    
    ZPic *current_data_obj=[self object_at_index:current_index];
    
    if(current_data_obj != data_obj)    current_data_obj.content=data_obj.content;
    
    
    [self update_object_to_server:data_obj];
    
}

-(BOOL) update_object_to_server:(ZPic *)data_obj
{
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/%@",host_name,app_name] ;
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=update_records&actionType=update&record_key=%@&description=%@",data_obj.instance_key,data_obj.content];
    
    
    [self send_request_server:url_string post_string:post_string];
    
    return YES;
    
}

-(NSString *) get_upload_url
{
    NSString *url_string=[[NSString alloc] initWithFormat:@"%@/%@",host_name,app_name];
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=get_upload_url"];
    
    NSString *response_string=@"";
    response_string= [self send_request_server:url_string post_string:post_string];
    NSError *error=[[NSError alloc] init];
    NSDictionary *json_obj=[NSJSONSerialization JSONObjectWithData:[response_string dataUsingEncoding:NSUTF8StringEncoding]  options:NSJSONReadingMutableContainers error:&error];
    if([[json_obj objectForKey:@"status"] isEqualToString:@"ok"]){
        return [json_obj objectForKey:@"upload_url"];
    }
    return @"";

}

-(NSString *) send_request_server:(NSString *)url_string post_string:(NSString *)post_string
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
    return response_string;
    
}




@end
