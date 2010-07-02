//
//  EditPickerEditor.h
//  ExoSQLite
//
//  Created by fj on 02/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditAttributeEditor.h"

@interface EditPickerEditor : EditAttributeEditor <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *myPicker;
	UITableView  *myTableView;
	NSArray *myArray;
	NSString *myString;
}

@property (nonatomic,retain) UIPickerView	*myPicker;
@property (nonatomic,retain) UITableView	*myTableView;
@property (nonatomic,retain) NSArray		*myArray;
@property (nonatomic,retain) NSString		*myString;




@end
