//
//  ListViewController.m
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import "ListViewController.h"
#import "ExoSQLiteAppDelegate.h"
#import "DetailViewController.h"

#include <sqlite3.h>

@implementation ListViewController

@synthesize myTableView;

NSString * PRIMARY_ID_KEY = @"primaryid";
NSString * NAME_KEY = @"name";
NSString * CITY_KEY = @"city";
NSString * ID_KEY = @"id";

NSString * SECTION_NAME [] = {@"Marseille", @"Nice", @"Berg"};

NSMutableArray * hotelList;

#pragma mark -
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
#pragma mark Database

-(void) loadDataFromDb {
    
    NSLog (@"loadDataFromDb");
    
    sqlite3 * db;
    int dbrc; // DataBase return code
    
    ExoSQLiteAppDelegate * appDelegate = (ExoSQLiteAppDelegate *) [UIApplication sharedApplication].delegate;
    
    const char* dbFilePathUTF8 = [appDelegate.dbFilePath UTF8String];
    
    dbrc = sqlite3_open(dbFilePathUTF8, &db);
    
    if (dbrc) {
        
        NSLog(@"Impossible d'ouvrir la DB");
        
    }
    
    NSLog(@"DB ouverte");
    
    sqlite3_stmt * dbps;
    
    // Indique ce que l'on veut récupérer dans la DB
    NSString * queryStatementNS = @"select name, city, id from hotellist order by id";
    
	const char *queryStatement = [queryStatementNS UTF8String];
    
    // Méthode SQLite qui va compiler la requète SQL en Byte-Code et qui prend 4 paramètre: 1.La connection à la DB 2.La déclaration qui sera compilée
    // 3. 
	dbrc = sqlite3_prepare_v2 (db, queryStatement, -1, &dbps, NULL); //                          ******* À REVOIR ********
    
	NSLog (@"Requête ok!");
    
	
	[hotelList release];
    
	hotelList = [[NSMutableArray alloc] initWithCapacity: 100]; // Arbitraire, on pourrai ne pas en mettre
    
    // itère chaque résultats de la requète et les convertis en objet Cocoa et on les met dans un NSDictionary 
    
    // Il va appeler sqlite3_step jusqu'à ce qu'il puisse retourner SQLITE_ROW. Si c'est le cas, une ligne de donnée est prête à être retourner avec la fonction 'column' de SQLite
    
    while ((dbrc = sqlite3_step(dbps)) == SQLITE_ROW) {
        
        NSString * nameValue = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(dbps, 0)];
                
        NSString * cityValue = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(dbps, 1)];
        
        int idValueI = sqlite3_column_int(dbps, 2);
        NSNumber * idValue = [[NSNumber alloc] initWithInt: idValueI];         
        
        NSMutableDictionary * rowDict = [[NSMutableDictionary alloc] initWithCapacity: 4];
        
            [rowDict setObject:nameValue forKey:NAME_KEY];
            [rowDict setObject:cityValue forKey:CITY_KEY];
            [rowDict setObject:idValue forKey:ID_KEY];
        
       // NSLog(@"%@", [rowDict description]); // Description OK 

        
        [hotelList addObject:rowDict];
        
       // NSLog(@"List Hotel: %@", hotelList); // Description OK
        
        
        [nameValue release];
        [cityValue release];
        [idValue release];
        [rowDict release];
    }
	
    
    
    sqlite3_finalize (dbps); // Finalise la déclaration 
	sqlite3_close(db); // Et on ferme la DB
    
    NSLog(@"Fermeture de la DB");
    
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
	[super viewDidLoad];

}


- (void)viewWillAppear:(BOOL)animated {
    
    [self loadDataFromDb];
    
    [self.myTableView reloadData];
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {

    [self.myTableView beginUpdates];
    
    [super viewDidAppear:animated];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.myTableView endUpdates];

    [super viewDidDisappear:animated];
}

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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [hotelList count];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
   
    // Configure the cell...
    
	NSDictionary *rowVals = (NSDictionary*) [hotelList objectAtIndex: indexPath.row];
    
    cell.textLabel.text = [rowVals objectForKey:CITY_KEY];
    cell.detailTextLabel.text = [rowVals objectForKey:NAME_KEY];
    
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
    // Navigation logic may go here. Create and push another view controller.
    
    DetailViewController * detailViewController = [[DetailViewController alloc] init];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];

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

- (void)addHotel {

}


- (void)dealloc {
    [super dealloc];
}


@end

