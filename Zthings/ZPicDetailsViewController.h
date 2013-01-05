//
//  ZPicDetailsViewController.h
//  Zthings
//
//  Created by Feng on 4/1/13.
//  Copyright (c) 2013 Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Update_Item_Delegate.h"
@class ZPic;
@interface ZPicDetailsViewController : UIViewController

@property (nonatomic) ZPic *detailItem;
@property (nonatomic) NSInteger current_index;
@property (nonatomic) id<Update_Item_Delegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@property (weak, nonatomic) IBOutlet UITextView *content_label;

- (IBAction)edit_current_item:(id)sender;
-(IBAction)commit_current_item:(id)sender;

@end
