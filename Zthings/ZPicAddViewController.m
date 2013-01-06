//
//  ZPicAddViewController.m
//  Zthings
//
//  Created by Feng on 5/1/13.
//  Copyright (c) 2013 Z. All rights reserved.
//

#import "ZPicAddViewController.h"
#import "ZPicViewController.h"
#import "ZPicDataController.h"
#import "ZPic.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface ZPicAddViewController ()
-(void) process_selected_image:(UIImage *) selected_image;
@end

@implementation ZPicAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPhotoAlbum:(id)sender {
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = delegate;
    [controller presentViewController:mediaUI animated:YES completion:nil];
    return YES;

    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"return_new_dataitem"]){
        
        if(self.image_view.image){
            //create the new dataitem
            
            NSString *content=self.content_input.text;
            ZPic *new_data_obj=[[ZPic alloc] init];
            new_data_obj.content=content;
            
            ZPicViewController *master_vc=[segue destinationViewController];
            [master_vc.data_controller add_object_at_head_with_image:new_data_obj image:self.image_view.image];
            [master_vc.tableView reloadData];
        }
        
        
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        // Do something with imageToUse
        
        [self process_selected_image:imageToUse];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) process_selected_image:(UIImage *)selected_image
{
    self.image_view.image=selected_image;
    self.image_view.contentMode=UIViewContentModeScaleAspectFit;
    
    //controlling the UI interactions for other controls
    self.content_input.text=@"What is in your mind?";
    self.content_input.editable=YES;
    
    
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView==self.content_input){
        
        if(self.image_view.image){
        
            self.content_input.text=@"";
            self.content_input.frame=CGRectMake(self.image_view.frame.origin.x, self.image_view.frame.origin.y, self.content_input.frame.size.width, 400);
            return YES;
        }else{
            self.content_input.text=@"Please first select the image to record";
            return NO;
        }
    }
    
return YES;

}


@end
