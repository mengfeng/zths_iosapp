//
//  AddDreamViewController.m
//  Zthings
//
//  Created by Feng on 31/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "AddDreamViewController.h"
#import "Dream.h"
#import "MasterViewController.h"
#import "DreamDataController.h"
@interface AddDreamViewController ()

-(BOOL) add_new_obj_to_server:(Dream *) data_obj;

@end

@implementation AddDreamViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.author_input){
        [textField resignFirstResponder];
    }
    
    return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"return_input"]){
        
        NSString *author=self.author_input.text;
        if([author isEqualToString:@""]) author=@"iPhone";
        NSString *content=self.content_input.text;
        NSString *title=@"";
        if( [content length]>16) title=[content substringToIndex:15];
        else title=content;
        NSString *email=@"";
        NSString *image_url=@"";
        NSString *image_key=@"";
        NSString *instance_key=@"";
        NSDate *date=[NSDate date];
        
        if([content length]>0){
            self.created_data_obj=[[Dream alloc] init_with_properties:author content:content image_url:image_url title:title email:email date:date instance_key:instance_key image_key:image_key];
        
            MasterViewController *master_VC=[segue destinationViewController];
            [master_VC.data_controller add_object_at_head:self.created_data_obj];
            [master_VC.tableView reloadData];
            [self add_new_obj_to_server:self.created_data_obj];
        }
    }
}


-(BOOL) add_new_obj_to_server:(Dream *)data_obj
{
    //NSString *url_string=@"http://zinthedream.appspot.com/zdream";
    NSString *url_string=@"http:localhost:8081/zdream";
    NSString *post_string=[[NSString alloc] initWithFormat:@"dispatcher=update_records&actionType=insert&author=%@&description=%@",data_obj.author,data_obj.content];
    
    //NSLog(@"The post string is %@", post_string);
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_string]];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[post_string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSHTTPURLResponse *response=nil;
    NSError *error=[[NSError alloc] init];
    NSData *response_data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *response_string=[[NSString alloc] initWithData:response_data encoding:NSUTF8StringEncoding];
    
    NSLog(@"The response string is %@", response_string);
    
    
        
    
    return YES;
}

@end
