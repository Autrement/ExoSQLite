//
//  EditPickerEditor.m
//  ExoSQLite
//
//  Created by fj on 02/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#include <sqlite3.h>
#import "EditPickerEditor.h"
#import "DetailViewController.h"
#import "ExoSQLiteAppDelegate.h"

@implementation EditPickerEditor

@synthesize  myPicker, myArray, myTableView, myString;

#pragma mark View lifecycle

-(void)loadView {
	[super loadView];
	UIView *myView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; 
	self.view = myView; 
	[myView release];
	
	UITableView *theTableView = [[UITableView alloc] initWithFrame: CGRectMake(0.0, 67.0, 320.0, 480.0) style:UITableViewStyleGrouped];
	theTableView.delegate = self; 
	theTableView.dataSource = self; 
	[self.view addSubview:theTableView]; 
	self.myTableView = theTableView; 
	[theTableView release];
	
	myArray = [[NSArray alloc] initWithObjects:@"Marseille", @"Nice", @"Berg",nil];
	
	
	UIPickerView *thePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 200.0, 320.0, 216.0)];
	thePicker.delegate = self;
	thePicker.dataSource = self;
	self.myPicker = thePicker;
	[thePicker release];
	[self.view addSubview:myPicker];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	myPicker.showsSelectionIndicator = YES;
	
	
}



#pragma mark -

- (void) updateDataFromDb {
	
	NSError *error; 
	if ([keyPath length] == 0)
		NSLog(@"Error saving: %@", [error localizedDescription]); 
	return;
	
	sqlite3 *db;
	int dbrc; 
	ExoSQLiteAppDelegate *appDelegate = (ExoSQLiteAppDelegate*)
	[UIApplication sharedApplication].delegate;
	const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
	dbrc = sqlite3_open (dbFilePathUTF8, &db);
	if (dbrc) {
		NSLog (@"couldn't open db:");
		return;
	}
	NSLog (@"opened db");
	sqlite3_stmt *dbps;
	NSString *insertStatementNS = [NSString stringWithFormat:
								   @"UPDATE city SET %@ WHERE id = %d", keyPath, detailController.getIdHotel];
	const char *insertStatement = [insertStatementNS UTF8String];
	dbrc = sqlite3_prepare_v2 (db, insertStatement, -1, &dbps, NULL);
	dbrc = sqlite3_step (dbps);
	
	sqlite3_finalize (dbps);
	sqlite3_close(db);
	
}


#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
	
	myString = [myArray objectAtIndex:row];
	[self.myTableView reloadData];
	
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	
	
	if (pickerView == myPicker)
	{
		if (component == 0)
		{
			returnStr = [myArray objectAtIndex:row];
		}
		else
		{
			returnStr = [[NSNumber numberWithInt:row] stringValue];
		}
	}
	
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
	
	if (component == 0)
		componentWidth = 240.0;	
	else
		componentWidth = 40.0;		
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [myArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *EditPickerEditorCell = @"EditPickerEditorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EditPickerEditorCell];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:EditPickerEditorCell] autorelease];
		cell.textLabel.font = [UIFont systemFontOfSize:17.0]; 
		cell.textLabel.textColor = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    }
    
	cell.textLabel.text = labelString;
	cell.detailTextLabel.text = myString;
	
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

-(IBAction)save { 
	myString = keyPath;
	self.updateDataFromDb;
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc {
	[myPicker release]; 
	[myTableView release];
	[myArray release];
    [super dealloc];
}




@end
