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
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.author_label.text = [self.detailItem author];
        self.title_label.text=[self.detailItem title];
        self.content_label.text=[self.detailItem content];
        [self.content_label sizeToFit];
        //NSLog(@"current content is %@", [self.detailItem content]);
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
