//
//  DetailViewController.h
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Update_Item_Delegate.h"
@class Dream;
@class MasterViewController;


@interface DetailViewController : UIViewController 

@property (strong, nonatomic) Dream *detailItem;
@property (nonatomic) NSInteger current_index;
@property  (nonatomic) id<Update_Item_Delegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *author_label;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UITextView *content_label;
@property (weak, nonatomic) IBOutlet UILabel *date_label;
- (IBAction)edit_current_item:(id)sender;
- (IBAction)commit_current_item:(id)sender;

@end
