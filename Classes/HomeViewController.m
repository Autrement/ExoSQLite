//
//  RootViewController.m
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright SUPINFO 2010. All rights reserved.
//

#include <sqlite3.h>
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "ListViewController.h"
#import "ExoSQLiteAppDelegate.h"


@implementation HomeViewController


@synthesize navController, detailController, listController;

NSString *NAME_DEFAULT = @"Hotel sans nom";
NSString *CITY_DEFAULT = @"Marseille";
int *ID_DEFAULT   = 0;


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void) insertDataInDb {
		
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
								   @"INSERT INTO hotellist(name, city, id)VALUES (%@, %@, %@)", NAME_DEFAULT, CITY_DEFAULT, ID_DEFAULT];
	const char *insertStatement = [insertStatementNS UTF8String];
	dbrc = sqlite3_prepare_v2 (db, insertStatement, -1, &dbps, NULL);
	dbrc = sqlite3_step (dbps);
	
	sqlite3_finalize (dbps);
	sqlite3_close(db);
	
	
}

- (IBAction)changeToList{
	
	[self.navigationController pushViewController:listController animated:YES];
}

- (IBAction)changeToAdd {
	
	self.insertDataInDb;
	detailController.setIdHotel(ID_DEFAULT);
    [self.navigationController pushViewController:detailController animated:YES];
}


- (void)dealloc {
	[detailController release];
	[navController release];
	[listController release];
    [super dealloc];
}


@end


