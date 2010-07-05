//
//  ExoSQLiteAppDelegate.h
//  ExoSQLite
//
//  Created by fj on 01/07/10.
//  Copyright SUPINFO 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExoSQLiteAppDelegate : NSObject <UIApplicationDelegate, UINavigationBarDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
    
    NSString * dbFilePath;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain, readonly) NSString * dbFilePath;

@end

