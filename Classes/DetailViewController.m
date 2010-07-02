//
//  DetailViewController.m
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import "DetailViewController.h"
#import "ExoSQLiteAppDelegate.h"
#import "ListViewController.h"
#import "EditAttributeEditor.h"
#include <sqlite3.h>


@implementation DetailViewController

@synthesize hotel, myTableView, idHotel;

NSString *NAME_KEY = @"name";
NSString *CITY_KEY = @"city";
NSString *ID_KEY   = @"id";


NSMutableArray *hotelDetailItems;

#pragma mark -
- (void) loadDataFromDb {
	NSLog (@"loadDataFromDb");
	
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
	
	NSString *queryStatementNS =
	(@"select %@, %@\
	from hotellist where %@ = %@", NAME_KEY, CITY_KEY, ID_KEY, idHotel);

	const char *queryStatement = [queryStatementNS UTF8String];
	dbrc = sqlite3_prepare_v2 (db, queryStatement, -1, &dbps, NULL);
	NSLog (@"prepared statement");
	
	[hotelDetailItems release];
	hotelDetailItems = [[NSMutableArray alloc] initWithCapacity: 100];
	
	while ((dbrc = sqlite3_step (dbps)) == SQLITE_ROW) {

		NSString *nameValue = [[NSString alloc]
							   initWithUTF8String: (char*) sqlite3_column_text (dbps, 0)];
		NSString *cityValue = [[NSString alloc] 
								initWithUTF8String: (char*) sqlite3_column_text (dbps, 1)];
		[hotelDetailItems addObject:nameValue];
		[hotelDetailItems addObject:cityValue];
		[nameValue release];
		[cityValue release];
	}
	
	idHotel = nil;
	sqlite3_finalize (dbps);
	sqlite3_close(db);
		
}
	
- (void)viewDidLoad {
    
    sectionNames = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Description Hôtel", @"Description"), nil];
    
    rowLabels = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Name",@"Name"), NSLocalizedString(@"City",@"City"), nil];
    
    rowController = [[NSArray alloc] initWithObjects:@"EditStringEditor",@"EditPickerEditor", nil];
    
    [super viewDidLoad];
	
	
}

- (void)viewWillAppear:(BOOL)animated {
	[self loadDataFromDb];
	[super viewWillAppear:animated];
	[self.tableView reloadData]; 
}


#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
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


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [sectionNames count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [rowLabels count];
}

- (NSString *)tableView:(UITableView *)theTableView titleForHeaderInSection:(NSInteger)section {
	id theTitle = [sectionNames objectAtIndex:section]; 
	
	if ([theTitle isKindOfClass:[NSNull class]]) 
		return nil; 
	
	return theTitle;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSUInteger row = [indexPath row];
	NSString *rowLabel = [rowLabels objectAtIndex:row];

    
    cell.detailTextLabel.text = [hotelDetailItems objectAtIndex: indexPath.row]; 
	cell.textLabel.text       = rowLabel;
	
    return cell;
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
	NSUInteger row = [indexPath row];
	
	NSString *controllerClassName = [rowController objectAtIndex:row];
	NSString *rowLabel = [rowLabels objectAtIndex:row];
	NSString *rowKey = [hotelDetailItems objectAtIndex: indexPath.row]; 
	Class controllerClass = NSClassFromString(controllerClassName);
	EditAttributeEditor *controller = [controllerClass alloc];
	controller = [controller initWithStyle:UITableViewStyleGrouped];
	controller.keyPath = rowKey;
	controller.labelString = rowLabel;
	controller.title = rowLabel;
    
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

