//
//  MasterViewController.m
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "DreamDataController.h"
#import "AddDreamViewController.h"
#import "Dream.h"
#import "ZthingsUtil.h"

@interface MasterViewController ()

-(void) setup_data_controller;


@end
@interface MasterViewController (){
    NSString *url_string;
    

}
@end


@implementation MasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup_data_controller];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data_controller count_of_dreams] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main_obj_cell" forIndexPath:indexPath];

    Dream *object = [self.data_controller object_at_index:indexPath.row];
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text=object.content;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
}


- (IBAction)refresh_btn_clicked:(id)sender {
    [self setup_data_controller];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"show_details"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Dream *object = [self.data_controller object_at_index:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

-(IBAction) done:(UIStoryboardSegue *)segue
{
    if([[segue identifier] isEqualToString:@"return_input"]){
        
    }
}

-(IBAction) cancel:(UIStoryboardSegue *)segue
{

}

-(void) setup_data_controller
{

    self.data_controller=[[DreamDataController alloc] init_data_from_remote_json:@"Dream"];
    
    
    [self.tableView reloadData];
    
}
@end
