//
//  ShoppingListViewController.h
//  Shopping_Portokalis_Christopher
//
//  Created by PORTOKALIS CHRISTOPHER G on 10/2/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ShoppingItem.h"

@interface ShoppingListViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray*  shoppingItemsArr;
@property (strong, nonatomic) NSMutableDictionary* combined;
@property (strong, nonatomic) NSString* inName;
@property (strong, nonatomic) NSIndexPath* rowIndex;
@property BOOL firstTime;

@end
