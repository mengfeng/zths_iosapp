//
//  Dream.m
//  Zthings
//
//  Created by Feng on 29/12/12.
//  Copyright (c) 2012 Z. All rights reserved.
//

#import "Dream.h"

@implementation Dream
@synthesize author=_author;
@synthesize content=_content;
@synthesize email=_email;
@synthesize date=_date;
@synthesize instance_key=_instance_key;

-(id) init_with_properties:(NSString *)author content:(NSString *)content email:(NSString *)email date:(NSDate *)date instance_key:(NSString *)instance_key
{
    self=[super init];
    if(self){
        self.author=author;
        self.content=content;
        self.email=email;
        self.date=date;
    }
    return self;
}

@end
