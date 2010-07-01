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


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

