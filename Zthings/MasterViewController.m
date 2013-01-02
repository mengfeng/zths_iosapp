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
-(void) init_data_from_remote_json:(NSString *) data_class;


@end
@interface MasterViewController (){
    NSString *url_string;
    

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
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self setup_data_controller];
    
    
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
    return [self.data_controller count_of_dreams] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main_obj_cell" forIndexPath:indexPath];

    Dream *object = [self.data_controller object_at_index:indexPath.row];
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text=object.content;
    //NSLog(@"Autho: %@, Content: %@", object.author, object.content);
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

    [self init_data_from_remote_json:@"Dream"];
    
    
    [self.tableView reloadData];
    
    //NSLog(@"Count of Dreams: %d",[self.data_controller count_of_dreams]);
}

-(void) init_data_from_remote_json:(NSString *)data_class
{
    self.data_controller = [[DreamDataController alloc] init];
    //url_string=[@"http://zinthedream.appspot.com/rpc?dispatcher=get_records&data_class=" stringByAppendingString:data_class];
    url_string=[@"http://localhost:8081/rpc?dispatcher=get_records&data_class=" stringByAppendingString:data_class];
        
    NSData *response_data=[NSMutableData data];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url_string]];
    //[[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSURLResponse *response=nil;
    NSError *error=[[NSError alloc] init];
    
    response_data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //NSLog(@"Data count after the URL Connection is %d", [self.data_controller count_of_dreams]);
    NSError *json_error=[[NSError alloc] init];
    NSDictionary *json_obj=[NSJSONSerialization JSONObjectWithData:response_data options:NSJSONReadingMutableContainers error:&json_error];
    
    if(json_obj){
        NSString *status=[json_obj objectForKey:@"status"];
        
        if([status isEqualToString:@"ok"]){
            
            //NSInteger records_count=(int)[json_obj objectForKey:@"records_count"];
            NSArray *records=[json_obj objectForKey:@"records"];
            for(NSDictionary *current_record in records){
                
                
                NSString *current_author=[current_record objectForKey:@"author"];
                NSString *current_content=[current_record objectForKey:@"record_content"];
                
                NSString *current_title=[current_record objectForKey:@"record_title"];
                
                NSString *date_string=[current_record objectForKey:@"created"];
                NSDateFormatter *current_date_formater=[[NSDateFormatter alloc] init];
                [current_date_formater setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss 'GMT'"] ;
                NSDate *current_date=[current_date_formater dateFromString:date_string];
                NSString *current_instance_key=[current_record objectForKey:@"record_key"];
                NSString *current_email=[current_record objectForKey:@"email"];
                NSString *current_image_url=[current_record objectForKey:@"image_url"];
                NSString *current_image_key=@"";
                
                [self.data_controller add_object_with_properties:current_author content:current_content image_url:current_image_url title:current_title email:current_email date:current_date instance_key:current_instance_key image_key:current_image_key];
                
                //NSLog(@"current author is %@, current content is %@", current_author, current_content);
                
                
            }
        }else{
            NSLog(@"JSON data contains error message: %@",[json_obj objectForKey:@"message"]);
            
        }
    }else{
        NSLog(@"Fail to fetch JSON data: %@", [json_error localizedDescription]);
    }
    
    //NSLog(@"current data count is %d", [self.data_controller count_of_dreams]);
    
    

}


@end
