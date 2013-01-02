//
//  Dream.m
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "Dream.h"

@implementation Dream

-(id) init_with_properties:(NSString *)author content:(NSString *)content image_url:(NSString *)image_url title:(NSString *)title email:(NSString *)email date:(NSDate *)date instance_key:(NSString *)instance_key image_key:(NSString *)image_key
{
    self=[super init];
    if(self){
        self.author=author;
        self.content=content;
        self.email=email;
        self.date=date;
        self.image_key=image_key;
        self.image_url=image_url;
        self.title=title;
        self.instance_key=instance_key;
    }
    return self;
}

@end
