//
//  ChoicesTableViewController.m
//  Shopping_Portokalis_Christopher
//
//  Created by PORTOKALIS CHRISTOPHER G on 10/2/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "ChoicesTableViewController.h"
#import "ShoppingListViewController.h"
#import "AddChoiceViewController.h"

@interface ChoicesTableViewController () <NSFetchedResultsControllerDelegate>
    @property (strong, nonatomic) NSString* addedChoice;
    @property BOOL firstTime;

@end

@implementation ChoicesTableViewController

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
    
    
    if(self.combined == nil)
    {
       self.combined = self.transfer;
        
        NSLog(@"in load if");
        
    }
    
    [self getSectionNames];
    
    
    
    
    NSLog(@"ViewDidLoad");
    

    
    
}


-(void)getSectionNames
{
    NSArray* temp = [self.combined allKeys];
    self.sortedSections = [temp sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sortedSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* key = self.sortedSections[section];
    NSArray* temp = self.combined[key];

    return  [temp count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self getSectionNames];
    NSString *key = self.sortedSections[indexPath.section];
    NSArray *temp = self.combined[key];
    ShoppingItem *item = temp[indexPath.row];
    static NSString *CellIdentifier = @"choicesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //NSLog(key);
   // NSLog([NSString stringWithFormat: @"%d", [temp count]]);
   // NSDictionary* dict = self.combined;
    cell.textLabel.text = item.itemName;
   
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return self.sortedSections[section];
}

-(IBAction) getUnwind: (UIStoryboardSegue*) segue
{
    
    AddChoiceViewController *sourceVC = segue.sourceViewController;
    
    //NSLog(sourceVC.addChoiceField.text);
    
   self.addedChoice = sourceVC.addChoiceField.text;
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"itemName"
                                                 ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    NSString* key = [self.addedChoice substringToIndex:1];
    NSArray* allkeys = [self.combined allKeys];
    NSString* capKey = [key capitalizedString];
    BOOL found = NO;
    BOOL foundName = NO;
    NSString* capName = [self.addedChoice capitalizedString];
    NSArray* findName = self.combined[capKey];
    NSMutableArray* oldTemp = [[NSMutableArray alloc] init];
    NSArray* sorted;
    ShoppingItem* nameItem;
    
    for(int i = 0; i < findName.count; i++)
    {
        
        nameItem = findName[i];
        
        if([nameItem.itemName isEqualToString:capName])
        {
            
            foundName = YES;
            break;
        }
        
        
    }
    
    
    
    for(int i = 0; i < allkeys.count; i++)
    {
        if(foundName == YES)
        {
            
            break;
            found = YES;
        }
        
        
        if([capKey isEqualToString: allkeys[i]])
        {
            
            oldTemp = self.combined[capKey];
            //self.addedChoice = [self.addedChoice capitalizedString];
            [oldTemp addObject: [ShoppingItem itemWithName: capName]];
            sorted = [oldTemp sortedArrayUsingDescriptors:@[sortDescriptor]];
            oldTemp = [[NSMutableArray alloc] init];
            for(ShoppingItem *item in sorted)
            {
                [oldTemp addObject: item];
            }
            
            
            [self.combined setObject: oldTemp forKey: capKey];
            found = YES;
            NSLog(@"old key");
            break;
        }
    }
    
    if(!found)
    {
        NSMutableArray* addtemp = [[NSMutableArray alloc] init];
        [addtemp addObject: [ShoppingItem itemWithName: [self.addedChoice capitalizedString]] ];
        NSLog(@"new key");
        [self.combined setObject: addtemp forKey:[key capitalizedString]];
            
    }
    
    
    
    [self getSectionNames];
    [self.tableView reloadData];
    
}


-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    self.segKey = self.sortedSections[indexPath.section];
    self.segCell = indexPath.row;
    
    [self performSegueWithIdentifier:@"choiceSeg" sender:self];
}




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


 //Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray* delete = self.combined[self.sortedSections[indexPath.section]];
        [delete removeObjectAtIndex: indexPath.row];
        [self.combined setObject: delete forKey:self.sortedSections[indexPath.section]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if( delete.count == 0 )
        {

            [self.combined removeObjectForKey: self.sortedSections[indexPath.section]];

            [self getSectionNames];
        }
        

        
    } else {
        NSLog(@"Unhandled editing style! %d", editingStyle);
    }
      [self.tableView reloadData];
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


#pragma mark - Navigation







@end
