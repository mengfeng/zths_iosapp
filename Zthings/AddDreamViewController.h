//
//  AddDreamViewController.h
//  Zthings
//
//  Created by Feng on 31/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dream;

@interface AddDreamViewController : UITableViewController <UITextFieldDelegate>

@property(strong,nonatomic) Dream *created_data_obj;

@property (weak, nonatomic) IBOutlet UITextField *author_input;
@property (weak, nonatomic) IBOutlet UITextView *content_input;

@end
