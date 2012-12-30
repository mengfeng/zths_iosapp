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
#import "Dream.h"

@interface MasterViewController ()

    -(void) _setup_data_controller;
    

@end
@interface MasterViewController (){

}
@end


@implementation MasterViewController
//@synthesize data_controller=_data_controller;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    [self _setup_data_controller];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    
    //[_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data_controller count_of_dreams] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Dream *object = [self.data_controller object_at_index:indexPath.row];
    cell.textLabel.text = object.author;
    cell.detailTextLabel.text=object.content;
    NSLog(@"Autho: %@, Content: %@", object.author, object.content);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Dream *object = [_data_controller object_at_index:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

-(void) _setup_data_controller
{
    
    if (!self.data_controller) {
        self.data_controller = [[DreamDataController alloc] init];
    }
    
    NSString *current_author=@"Meng Feng";
    NSString *current_content=@"Dreams are hard to remember";
    NSDate *current_date=[NSDate date];
    NSString *current_instance_key=@"SOMEDummyKey";
    NSString *current_email=@"mengfeng0904@gmail.com";
    
    
    [self.data_controller add_object_with_properties:current_author content:current_content email: current_email date:current_date instance_key:current_instance_key];
    
    NSLog(@"Count of Dreams: %d",[self.data_controller count_of_dreams]);
}


@end
