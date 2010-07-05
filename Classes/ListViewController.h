//
//  ListViewController.h
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;


@interface ListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{

    UITableView * myTableView;
    
    DetailViewController * detailViewController;

}

@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) IBOutlet DetailViewController * detailViewController;



- (void)addHotel;


@end



