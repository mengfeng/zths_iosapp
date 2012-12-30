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

-(id) init_from_remote_json:(NSString *)data_class
{
    self=[self init];
    
    url_string=[@"http://zinthedream.appspot.com/rpc?dispatcher=get_records&data_class=" stringByAppendingString:data_class];
    //NSLog(@"remote url is %@", url_string);

    response_data=[NSMutableData data];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url_string]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    NSLog(@"Data count after the URL Connection is %d", [self count_of_dreams]);
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

-(void)connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [response_data setLength:0];
}

-(void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data
{
    [response_data appendData:data];
}


-(void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error
{
    NSLog(@"connection fails with error description: %@", [error description]);
}

-(void)connectionDidFinishLoading: (NSURLConnection *)connection
{
    //[connection release];
    //NSString *response_string=[[NSString alloc] initWithData:response_data encoding:NSUTF8StringEncoding];
    
    NSError *json_error=[[NSError alloc] init];
    NSDictionary *json_obj=[NSJSONSerialization JSONObjectWithData:response_data options:NSJSONReadingMutableContainers error:&json_error];
    
    if(json_obj){
        
        //NSInteger records_count=(int)[json_obj objectForKey:@"records_count"];
        NSArray *records=[json_obj objectForKey:@"records"];
        
        for(NSDictionary *current_record in records){
            
            NSString *current_author=[current_record objectForKey:@"author"];
            NSString *current_content=[current_record objectForKey:@"record_content"];
            NSString *current_title=[current_record objectForKey:@"title"];

            NSDate *current_date=[NSDate date];
            NSString *current_instance_key=[current_record objectForKey:@"record_key"];
            NSString *current_email=[current_record objectForKey:@"email"];
            NSString *current_image_url=[current_record objectForKey:@"image_url"];
            NSString *current_image_key=@"";
            
            [self add_object_with_properties:current_author content:current_content image_url:current_image_url title:current_title email:current_email date:current_date instance_key:current_instance_key image_key:current_image_key];
            
            //NSLog(@"current author is %@, current content is %@", current_author, current_content);
        }
        
        //NSLog(@"current data count is %d", [self count_of_dreams]);
    }
    
    
}


@end
