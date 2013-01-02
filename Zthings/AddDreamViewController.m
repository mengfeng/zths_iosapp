//
//  AddDreamViewController.m
//  Zthings
//
//  Created by Feng on 31/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "AddDreamViewController.h"
#import "Dream.h"

@interface AddDreamViewController ()

-(BOOL) add_new_obj;

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
    if(textField==self.author_input || textField==self.title_input){
        [textField resignFirstResponder];
    }
    
    return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"return_input"]){
        [self add_new_obj];
    }
}


-(BOOL) add_new_obj
{
    NSString *author=self.author_input.text;
    NSString *title=self.title_input.text;
    NSString *content=self.content_input.text;
    NSString *email=@"";
    NSString *image_url=@"";
    NSString *image_key=@"";
    NSString *instance_key=@"";
    NSDate *date=[NSDate date];
    
    if([content length]>0){
        self.created_data_obj=[[Dream alloc] init_with_properties:author content:content image_url:image_url title:title email:email date:date instance_key:instance_key image_key:image_key];
    }
    
    return YES;
}

@end
