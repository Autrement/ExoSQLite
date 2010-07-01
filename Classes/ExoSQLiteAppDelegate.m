//
//  ExoSQLiteAppDelegate.m
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright SUPINFO 2010. All rights reserved.
//

#import "ExoSQLiteAppDelegate.h"
#import "HomeViewController.h"


@implementation ExoSQLiteAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize dbFilePath;

NSString *DATABASE_RESOURCE_NAME = @"hotel";
NSString *DATABASE_RESOURCE_TYPE = @"db";
NSString *DATABASE_FILE_NAME = @"hotel.db";

#pragma mark -

- (BOOL) initializeDb {
	NSLog (@"initializeDB");
	// look to see if DB is in known location (~/Documents/$DATABASE_FILE_NAME)
	//START:code.DatabaseShoppingList.findDocumentsDirectory
	NSArray *searchPaths =
	NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
	dbFilePath = [documentFolderPath stringByAppendingPathComponent:
				  DATABASE_FILE_NAME];
	//END:code.DatabaseShoppingList.findDocumentsDirectory
	[dbFilePath retain];
	//START:code.DatabaseShoppingList.copyDatabaseFileToDocuments
	if (! [[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {
		// didn't find db, need to copy
		NSString *backupDbPath = [[NSBundle mainBundle]
								  pathForResource:DATABASE_RESOURCE_NAME
								  ofType:DATABASE_RESOURCE_TYPE];
		if (backupDbPath == nil) {
			// couldn't find backup db to copy, bail
			return NO;
		} else {
			BOOL copiedBackupDb = [[NSFileManager defaultManager]
								   copyItemAtPath:backupDbPath
								   toPath:dbFilePath
								   error:nil];
			if (! copiedBackupDb) {
				// copying backup db failed, bail
				return NO;
			}
		}
	}
	return YES;
	//END:code.DatabaseShoppingList.copyDatabaseFileToDocuments
	NSLog (@"bottom of initializeDb");
}

#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// copy the database from the bundle if necessary
	if (! [self initializeDb]) {
		// TODO: alert the user!
		NSLog (@"couldn't init db");
		return;
	}	
	
    // Add the tab bar controller's current view as a subview of the window
    [window insertSubview:navigationController.view atIndex:0];
}




- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[dbFilePath release];
	[super dealloc];
}


@end

