//
//  RootViewController.m
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright SUPINFO 2010. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "ListViewController.h"


@implementation HomeViewController




@synthesize navController, detailController, listController;





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (IBAction)changeToList{
	
	[self.navigationController pushViewController:listController animated:YES];
}

- (IBAction)changeToAdd {
	
	listController.addHotel;
    [self.navigationController pushViewController:detailController animated:YES];
}


- (void)dealloc {
	[detailController release];
	[navController release];
	[listController release];
    [super dealloc];
}


@end


