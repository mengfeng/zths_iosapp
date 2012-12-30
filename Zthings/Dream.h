//
//  Dream.h
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dream : NSObject

@property (nonatomic) NSString *author;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *email;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *instance_key;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *image_url;
@property (nonatomic) NSString *image_key;

-(id) init_with_properties:(NSString *) author
                 content:(NSString *) content
                 image_url:(NSString *) image_url
                     title:(NSString *) title
                   email:(NSString *) email
                    date:(NSDate *) date
            instance_key:(NSString *) instance_key
                 image_key:(NSString *) image_key;


@end
