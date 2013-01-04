//
//  Update_Item.h
//  Zthings
//
//  Created by Feng on 3/1/13.
//  Copyright (c) 2013 Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Update_Item_Delegate <NSObject>
@optional
-(BOOL)commit_current_item:(id)data_item current_index:(NSInteger) current_index;

@end
