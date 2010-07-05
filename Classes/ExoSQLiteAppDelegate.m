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

@synthesize window, dbFilePath;
@synthesize navigationController;

NSString *DATABASE_RESOURCE_NAME = @"hotel";
NSString *DATABASE_RESOURCE_TYPE = @"db";
NSString *DATABASE_FILE_NAME = @"hotel.db";

#pragma mark Application lifecycle

- (BOOL) initializeDb {
	
    NSLog (@"Début initializeDB");
    
    // Va voir si il trouve bien le fichier DATABASE_FILE_NAME
    
	NSArray *searchPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
	
    dbFilePath = [documentFolderPath stringByAppendingPathComponent: DATABASE_FILE_NAME];

	[dbFilePath retain];
    
    // NSLog(@"dbFilePath: %@", dbFilePath); // Chemin d'accès OK 
    
	if (! [[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {

		NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:DATABASE_RESOURCE_NAME ofType:DATABASE_RESOURCE_TYPE];
        
      //  NSLog(@"BackupDbPath: %@", backupDbPath); // OK il ne rentre pas dans le if
		
        if (backupDbPath == nil) {

			return NO;
            
		} 
        else {
			BOOL copiedBackupDb = [[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
			
            if (! copiedBackupDb) {

				return NO;
			}
		}
	}
    
    NSLog (@"Fin initializeDB");
    
	return YES;


}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
    if (! [self initializeDb]) {
        
        NSLog(@"DB pas initialisée");
        
    } else {
        
        NSLog(@"DB Initialisée");
        
    }

    
    
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
    
	return YES;
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

