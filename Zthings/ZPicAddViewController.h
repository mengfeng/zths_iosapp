//
//  ZPicAddViewController.h
//  Zthings
//
//  Created by Feng on 5/1/13.
//  Copyright (c) 2013 Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPicAddViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate>
- (IBAction)showPhotoAlbum:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image_view;
@property (weak, nonatomic) IBOutlet UITextView *content_input;

@end
