//
//  EditStringEditor.h
//  ExoSQLite
//
//  Created by fj on 02/07/10.
//  Copyright 2010 SUPINFO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditAttributeEditor.h"

#define kLabelTag   1
#define kTextFieldTag   2

@class DetailViewController;


@interface EditStringEditor : EditAttributeEditor {
	DetailViewController *detailController;

}

@property (nonatomic, retain) DetailViewController *detailController;


@end
