//
//  ZPicDetailsViewController.m
//  Zthings
//
//  Created by Feng on 4/1/13.
//  Copyright (c) 2013 Z. All rights reserved.
//

#import "ZPicDetailsViewController.h"
#import "ZPic.h"
@interface ZPicDetailsViewController ()
-(void) configureView;
@end

@implementation ZPicDetailsViewController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
	
}

-(void) configureView
{
    if(self.detailItem){
        self.image_view.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.detailItem.image_url]]];
        self.image_view.contentMode=UIViewContentModeScaleAspectFit;
        //[self.image_view sizeToFit];
        self.content_label.text=self.detailItem.content;
        
        UIBarButtonItem *btn_edit = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Edit"
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(edit_current_item:)];
        self.navigationItem.rightBarButtonItem = btn_edit;

        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit_current_item:(id)sender {
    self.image_view.hidden=YES;
    self.content_label.frame=CGRectMake(self.image_view.frame.origin.x, self.image_view.frame.origin.y, self.content_label.frame.size.width,200);
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
