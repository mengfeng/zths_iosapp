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
-(void) init_data_from_remote_json:(NSString *) data_class;


@end
@interface MasterViewController (){
    NSString *url_string;
    NSMutableData *response_data;

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
    
    [self init_data_from_remote_json:@"Dream"];
    
    //NSLog(@"Count of Dreams: %d",[self.data_controller count_of_dreams]);
}

-(void) init_data_from_remote_json:(NSString *)data_class
{
    url_string=[@"http://zinthedream.appspot.com/rpc?dispatcher=get_records&data_class=" stringByAppendingString:data_class];
    //NSLog(@"remote url is %@", url_string);
    
    response_data=[NSMutableData data];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url_string]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    NSLog(@"Data count after the URL Connection is %d", [self.data_controller count_of_dreams]);
    
}

-(void)connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [response_data setLength:0];
}

-(void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data
{
    [response_data appendData:data];
}


-(void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error
{
    NSLog(@"connection fails with error description: %@", [error description]);
}

-(void)connectionDidFinishLoading: (NSURLConnection *)connection
{
    //[connection release];
    //NSString *response_string=[[NSString alloc] initWithData:response_data encoding:NSUTF8StringEncoding];
    
    NSError *json_error=[[NSError alloc] init];
    NSDictionary *json_obj=[NSJSONSerialization JSONObjectWithData:response_data options:NSJSONReadingMutableContainers error:&json_error];
    
    if(json_obj){
        
        //NSInteger records_count=(int)[json_obj objectForKey:@"records_count"];
        NSArray *records=[json_obj objectForKey:@"records"];
        
        for(NSDictionary *current_record in records){
            
            NSString *current_author=[current_record objectForKey:@"author"];
            NSString *current_content=[current_record objectForKey:@"record_content"];
            NSString *current_title=[current_record objectForKey:@"record_title"];
            
            NSDate *current_date=[NSDate date];
            NSString *current_instance_key=[current_record objectForKey:@"record_key"];
            NSString *current_email=[current_record objectForKey:@"email"];
            NSString *current_image_url=[current_record objectForKey:@"image_url"];
            NSString *current_image_key=@"";
            
            [self.data_controller add_object_with_properties:current_author content:current_content image_url:current_image_url title:current_title email:current_email date:current_date instance_key:current_instance_key image_key:current_image_key];
            
            //NSLog(@"current author is %@, current content is %@", current_author, current_content);
        }
        
        NSLog(@"current data count is %d", [self.data_controller count_of_dreams]);
        
        [self.tableView reloadData];
    }
    
    
}




@end
