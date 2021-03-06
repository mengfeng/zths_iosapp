//
//  MasterViewController.h
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Update_Item_Delegate.h"
@class DreamDataController;
@class Dream;
@class ZthingsUtil;

@interface MasterViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate, Update_Item_Delegate>
@property (strong, nonatomic) DreamDataController *data_controller;


- (IBAction)refresh_btn_clicked:(id)sender;
-(IBAction) done:(UIStoryboardSegue *) segue;
-(IBAction) cancel:(UIStoryboardSegue *) segue;


@end
