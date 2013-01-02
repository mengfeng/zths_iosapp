//
//  DetailViewController.m
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "DetailViewController.h"
#import "Dream.h"
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
        self.author_label.text = [self.detailItem author];
        self.title_label.text=[self.detailItem title];
        self.content_label.text=[self.detailItem content];
        NSDateFormatter *current_date_formatter=[[NSDateFormatter alloc] init];
        [current_date_formatter setDateFormat:@"EEE, dd MMM yyyy"];
        NSString *current_date_string=[current_date_formatter stringFromDate:[self.detailItem date]];
        self.date_label.text=current_date_string;
        [self.content_label sizeToFit];
       
        
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

@end
