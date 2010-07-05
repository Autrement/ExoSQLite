//
//  ListViewController.h
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{

    UITableView * myTableView;

}

@property (nonatomic, retain) UITableView * myTableView;


- (void)addHotel;


@end



