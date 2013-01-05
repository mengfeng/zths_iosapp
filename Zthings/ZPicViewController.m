//
//  ZPicViewController.m
//  Zthings
//
//  Created by Feng on 4/1/13.
//  Copyright (c) 2013 Z. All rights reserved.
//

#import "ZPicViewController.h"
#import "ZPicDataController.h"
#import "ZPic.h"
#import "ZPicDetailsViewController.h"
@interface ZPicViewController ()
-(void) setup_data_controller;
@end

@implementation ZPicViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data_controller count_of_objects] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zpic_main_cell" forIndexPath:indexPath];
    ZPic *current_obj=[self.data_controller object_at_index:indexPath.row];
    
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:1];
    UILabel *textLabel=(UILabel *)[cell viewWithTag:2];

//    //UIImageView *imageView=[[UIImageView alloc] init];
//    cell.imageView.frame=CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 140, 89);
//    cell.imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:current_obj.image_url]]];    
    
    textLabel.numberOfLines=4;
    textLabel.font=[UIFont systemFontOfSize:13];
    textLabel.text
    =current_obj.content;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.data_controller remove_object_at_index:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


- (IBAction)refresh_btn_clicked:(id)sender {
    [self setup_data_controller];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"show_pic_details"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ZPic *object = [self.data_controller object_at_index:indexPath.row];
        
        [[segue destinationViewController] setDetailItem:object];
        [[segue destinationViewController] setCurrent_index:indexPath.row];
        [[segue destinationViewController] setDelegate:self];
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

-(BOOL) commit_current_item:(id)data_item current_index:(NSInteger)current_index
{
    [self.data_controller update_object:data_item current_index:current_index];
    [self.tableView reloadData];
    
    return YES;
    
}

-(void) setup_data_controller
{
    
    self.data_controller=[[ZPicDataController alloc] init_data_from_remote_json:@"ZPicLife"];
    
    
    [self.tableView reloadData];
    
}


@end
