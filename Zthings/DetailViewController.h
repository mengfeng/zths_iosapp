//
//  DetailViewController.h
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
