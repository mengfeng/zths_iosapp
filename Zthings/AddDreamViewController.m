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
           
        }
    }
}



@end
