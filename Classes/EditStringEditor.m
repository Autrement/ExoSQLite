//
//  EditStringEditor.m
//  ExoSQLite
//
//  Created by fj on 02/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#include <sqlite3.h>
#import "EditStringEditor.h"
#import "DetailViewController.h"
#import "ExoSQLiteAppDelegate.h"

@implementation EditStringEditor

@synthesize detailController;

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
								   @"UPDATE name SET %@ WHERE id = %d", keyPath, detailController.getIdHotel];
	const char *insertStatement = [insertStatementNS UTF8String];
	dbrc = sqlite3_prepare_v2 (db, insertStatement, -1, &dbps, NULL);
	dbrc = sqlite3_step (dbps);

	sqlite3_finalize (dbps);
	sqlite3_close(db);
	
}

#pragma mark View lifecycle
/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */

/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }
 */

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
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
    
    static NSString *EditStringEditorCell = @"EditStringEditorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EditStringEditorCell];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EditStringEditorCell] autorelease];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 25)];
		label.textAlignment = UITextAlignmentRight;
		label.tag = kLabelTag; 
		UIFont *font = [UIFont boldSystemFontOfSize:14.0]; 
		label.textColor = kNonEditableTextColor; 
		label.font = font; 
		[cell.contentView addSubview:label]; 
		[label release];
		UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 190, 25)];
		[cell.contentView addSubview:theTextField]; 
		theTextField.tag = kTextFieldTag; 
		[theTextField release];
	}
    
	UILabel *label = (UILabel *)[cell.contentView viewWithTag:kLabelTag];
	
	label.text = labelString; 

	// A Finir !
	
	return cell;
	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
	NSUInteger onlyRow[] = {0, 0}; 
	NSIndexPath *onlyRowPath = [NSIndexPath indexPathWithIndexes:onlyRow length:2]; 
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:onlyRowPath]; 
	UITextField *textField = (UITextField *)[cell.contentView viewWithTag:kTextFieldTag]; 
	textField.text = keyPath;
	self.updateDataFromDb;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [super dealloc];
}


@end

