//
//  DetailViewController.h
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ListViewController;


@interface DetailViewController : UITableViewController {
	
	UITableView * myTableView;
	ListViewController * hotel;
	NSString * idHotel;
	
@private
    
    NSArray * sectionNames;
    NSArray * rowLabels;
    NSArray * rowKeys;
    NSArray * rowController;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet ListViewController * hotel;
@property (nonatomic, retain) NSString * idHotel;

@end
