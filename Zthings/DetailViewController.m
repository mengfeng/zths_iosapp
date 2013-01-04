//
//  DetailViewController.m
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "DetailViewController.h"
#import "Dream.h"
#import "MasterViewController.h"
#import "DreamDataController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


- (void)configureView
{
    
    if (self.detailItem) {
        self.author_label.text = self.detailItem.author;
        self.title_label.text=self.detailItem.title;
        self.content_label.text=self.detailItem.content;
        NSDateFormatter *current_date_formatter=[[NSDateFormatter alloc] init];
        [current_date_formatter setDateFormat:@"EEE, dd MMM yyyy"];
        NSString *current_date_string=[current_date_formatter stringFromDate:self.detailItem.date];
        self.date_label.text=current_date_string;
        [self.content_label sizeToFit];
       
        
        //initialize the nav bar
        UIBarButtonItem *btn_edit = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Edit"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(edit_current_item:)];
        self.navigationItem.rightBarButtonItem = btn_edit;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit_current_item:(id)sender {
    self.content_label.editable=YES;
    [self.content_label becomeFirstResponder];
    
    UIBarButtonItem *btn_done = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Done"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(commit_current_item:)];
    
    self.navigationItem.rightBarButtonItem = btn_done;
    
}

-(IBAction)commit_current_item:(id)sender

{
    
    
    if(![self.content_label.text isEqualToString:self.detailItem.content]){
        self.detailItem.content=self.content_label.text;
        [self.delegate commit_current_item:self.detailItem current_index:self.current_index];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
