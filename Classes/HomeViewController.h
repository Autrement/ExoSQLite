//
//  RootViewController.h
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright SUPINFO 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController, ListViewController;

@interface HomeViewController : UIViewController {
	
	UINavigationController * navController;
	DetailViewController * detailController;
	ListViewController * listController;

}
	
@property (nonatomic, retain) IBOutlet UINavigationController * navController;
@property (nonatomic, retain) IBOutlet DetailViewController * detailController;
@property (nonatomic, retain) IBOutlet ListViewController * listController;
	
- (IBAction) changeToAdd; 
- (IBAction) changeToList; 
	
@end