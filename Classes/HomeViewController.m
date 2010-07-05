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
NSNumber *ID_DEFAULT   = 0;


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void) generateId {
	
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
	NSLog (@"opened db : generateId");
	sqlite3_stmt *dbps;
	NSString *queryStatementNS =
	(@"select MAX(id) from hotellist");
	
	const char *queryStatement = [queryStatementNS UTF8String];
	dbrc = sqlite3_prepare_v2 (db, queryStatement, -1, &dbps, NULL);
	NSLog (@"prepared statement");
	while ((dbrc = sqlite3_step (dbps)) == SQLITE_ROW) {
		int idValueI = sqlite3_column_int(dbps, 3);
		NSNumber *idValue = [[NSNumber alloc]
								initWithInt: idValueI];
		idValue = ID_DEFAULT + 1;
		NSLog("id generer : %d", [ID_DEFAULT intValue]);
	}
//	TEST GENERATE & INSERT
//	
//	sqlite3_stmt *dbps2;
//	NSString *insertStatementNS = [NSString stringWithFormat:
//								   @"INSERT INTO hotellist(name, city, id)VALUES (%@, %@, %@)", NAME_DEFAULT, CITY_DEFAULT, ID_DEFAULT];
//	const char *insertStatement = [insertStatementNS UTF8String];
//	dbrc = sqlite3_prepare_v2 (db, insertStatement, -1, &dbps2, NULL);
//	dbrc = sqlite3_step (dbps2);
//	
	
//	sqlite3_finalize (dbps2);
	sqlite3_finalize (dbps);
	sqlite3_close(db);
	
}

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
	NSLog (@"opened db : insertDataInDb");
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
	
	self.generateId;
	self.insertDataInDb;
	[detailController setIdHotel:ID_DEFAULT]; 
    [self.navigationController pushViewController:detailController animated:YES];
}


- (void)dealloc {
	[detailController release];
	[navController release];
	[listController release];
    [super dealloc];
}


@end


