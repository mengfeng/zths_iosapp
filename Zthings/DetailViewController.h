//
//  DetailViewController.h
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dream;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *author_label;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UITextView *content_label;
@property (weak, nonatomic) IBOutlet UILabel *date_label;

@end
