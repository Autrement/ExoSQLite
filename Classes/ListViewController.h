//
//  ListViewController.h
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListViewController : UITableViewController {
	
	NSString * myName;
	NSString * myCity;

}

@property (nonatomic, retain) NSString * myName;
@property (nonatomic, retain) NSString * myCity;


- (void)addHotel;

@end
