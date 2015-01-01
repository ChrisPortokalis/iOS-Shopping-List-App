//
//  ChoicesTableViewController.h
//  Shopping_Portokalis_Christopher
//
//  Created by PORTOKALIS CHRISTOPHER G on 10/2/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingItem.h"

@interface ChoicesTableViewController : UITableViewController

@property (strong, nonatomic) NSArray* sortedSections;
@property (strong, nonatomic, retain) NSMutableDictionary* transfer;
@property (strong, nonatomic) NSMutableDictionary* combined;
@property (strong, nonatomic) NSString* segKey;
@property int segCell;

@end
