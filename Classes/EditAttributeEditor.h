//
//  EditAttributeEditor.h
//  ExoSQLite
//
//  Created by fj on 02/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNonEditableTextColor	[UIColor colorWithRed:.318 green:0.4 blue:.569 alpha:1.0]

@interface EditAttributeEditor : UITableViewController {
	NSString * keyPath;
    NSString * labelString;
}

@property (nonatomic, retain) NSString          * keyPath; 
@property (nonatomic, retain) NSString          * labelString; 

-(IBAction)cancel;
-(IBAction)save;


@end