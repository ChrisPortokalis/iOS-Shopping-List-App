//
//  ShoppingListViewController.m
//  Shopping_Portokalis_Christopher
//
//  Created by PORTOKALIS CHRISTOPHER G on 10/2/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "ShoppingListViewController.h"
#import "ChoicesTableViewController.h"

@interface ShoppingListViewController () <NSFetchedResultsControllerDelegate>
@property int cellIndex;
@property (strong, nonatomic) NSString* inKey;


@end

@implementation ShoppingListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *myTrash = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemTrash
                                                                             target: self
                                                                            action: @selector(deleteHandler)];
    
    
     NSArray* barButtons = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myTrash];
    self.navigationItem.rightBarButtonItems = barButtons;
    
    
    
    self.shoppingItemsArr = [[NSMutableArray alloc] init];
    self.rowIndex = [[NSIndexPath alloc] init];
    
    
    NSMutableArray* temp = [[NSMutableArray alloc] init];
    self.combined = [[NSMutableDictionary alloc]init];
    
    [self.combined setObject: temp forKey: @"A"];
    [[self.combined objectForKey:@"A"] addObject: [ShoppingItem itemWithName: @"Apples"]];
    
    NSMutableArray* temp2 = [[NSMutableArray alloc] init];
    [self.combined setObject: temp2 forKey: @"B"];
    [[self.combined objectForKey:@"B"] addObject: [ShoppingItem itemWithName: @"Bread"]];
    [[self.combined objectForKey:@"B"] addObject: [ShoppingItem itemWithName: @"Butter"]];
    
    NSMutableArray* temp3 = [[NSMutableArray alloc] init];
    [self.combined setObject: temp3 forKey: @"C"];
    [[self.combined objectForKey:@"C"] addObject: [ShoppingItem itemWithName: @"Cheese"]];
    
    NSMutableArray* temp4 = [[NSMutableArray alloc] init];
    [self.combined setObject: temp4 forKey: @"E"];
    [[self.combined objectForKey: @"E"] addObject: [ShoppingItem itemWithName:@"Eggs"]];
    
    NSMutableArray* temp5 = [[NSMutableArray alloc] init];
    [self.combined setObject: temp5 forKey: @"G"];
    [[self.combined objectForKey: @"G"] addObject: [ShoppingItem itemWithName:@"Grapes"]];
    
    NSMutableArray* temp6 = [[NSMutableArray alloc] init];
    [self.combined setObject: temp6 forKey: @"I"];
    [[self.combined objectForKey: @"I"] addObject: [ShoppingItem itemWithName:@"Ice Cream"]];
    
    NSMutableArray* temp7 = [[NSMutableArray alloc] init];
    [self.combined setObject: temp7 forKey: @"M"];
    [[self.combined objectForKey: @"M"] addObject: [ShoppingItem itemWithName:@"Milk"]];
    
    NSMutableArray* temp8 = [[NSMutableArray alloc] init];
    [self.combined setObject: temp8 forKey: @"O"];
    [[self.combined objectForKey: @"O"] addObject: [ShoppingItem itemWithName:@"Oranges"]];
    [[self.combined objectForKey: @"O"] addObject: [ShoppingItem itemWithName:@"Oreos"]];
 

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.shoppingItemsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingItem* item = self.shoppingItemsArr [indexPath.row];
    static NSString *CellIdentifier = @"shopListCells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = item.itemName;
    
    if(item.checked == NO)
    {
        cell.imageView.image = [UIImage imageNamed: @"ubox.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed: @"cbox.png"];
        
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", item.itemCount];
    
    
    return cell;
}

-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    ShoppingItem* item = self.shoppingItemsArr [indexPath.row];
    
    if(item.checked == NO)
    {
        item.checked = YES;
    }
    else
    {
        item.checked = NO;
    }
    
    [tableView reloadData];
    
}

-(IBAction) unwindToShop: (UIStoryboardSegue*) segue sender: (UITableViewCell*) sender
{
    BOOL found = NO;
    ChoicesTableViewController *sourceVC = segue.sourceViewController;
    

    NSString* string;
    NSString* key = sourceVC.segKey;
    int index = sourceVC.segCell;
    
    NSMutableArray* temp = [[NSMutableArray alloc] initWithArray:sourceVC.combined[key]];
    
   ShoppingItem* item = temp[index];
    NSString* name = item.itemName;
    ShoppingItem* inArrItem;
   for(int i =0; i < self.shoppingItemsArr.count; i++)
    {
        inArrItem = self.shoppingItemsArr[i];
        string = inArrItem.itemName;
        
        if([string isEqualToString: item.itemName])
        {
            
            inArrItem.itemCount++;
            self.shoppingItemsArr[i] = inArrItem;
            found = YES;
            break;
            
        }

    }
    
    if(found == NO)
    {
    
        [self.shoppingItemsArr addObject: [ShoppingItem itemWithName:name]];
      }

    [self.tableView reloadData];
    
    //found = NO;
    
    NSLog(@"Unwinded");
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ChoicesTableViewController* destVC = segue.destinationViewController;
    
    destVC.transfer = self.combined;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.rowIndex = indexPath;
    
    ShoppingItem* item = self.shoppingItemsArr[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
    
        if(item.itemCount > 1)
        {
            self.cellIndex = indexPath.row;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Item Count is More Than One" message:@"Delete One or All?" delegate:self cancelButtonTitle:@"1" otherButtonTitles:@"All",nil];
            [alert show];

        }
        else if(item.itemCount == 1)
        {

            [self.shoppingItemsArr removeObjectAtIndex: indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
              [self.tableView reloadData];
        }
        
        
        
    } else {
        NSLog(@"Unhandled editing style! %d", editingStyle);
    }
    

    
  
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
   
        if (buttonIndex == 0) {
            ShoppingItem* item = self.shoppingItemsArr[self.cellIndex];
            item.itemCount--;
            self.shoppingItemsArr[self.cellIndex] = item;
            [self.tableView reloadData];
       
        }
        else if (buttonIndex == 1) {
        
            //if all is checked
            ShoppingItem* item = self.shoppingItemsArr[self.cellIndex];
            [self.shoppingItemsArr removeObjectAtIndex:self.cellIndex];
        
        
            [self.tableView deleteRowsAtIndexPaths:@[self.rowIndex] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        ShoppingItem* item;
        
       for(int i = self.shoppingItemsArr.count-1; i >= 0; i--)
       {
           item = self.shoppingItemsArr[i];
           
           if(item.checked == YES)
           {
               [self.shoppingItemsArr removeObjectAtIndex:i];
           }
           
        }
        
        [self.tableView reloadData];
    } 
}


-(void)deleteHandler
{
    
    UIAlertView *deleteAlert = [[UIAlertView alloc] initWithTitle:@"Delete All Items?" message: @"are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes",nil];
    [deleteAlert show];
    
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
