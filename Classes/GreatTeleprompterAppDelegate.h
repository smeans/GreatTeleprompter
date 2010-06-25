//
//  GreatTeleprompterAppDelegate.h
//  GreatTeleprompter
//
//  Created by Scott Means on 4/4/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface GreatTeleprompterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
	NSString *currentSpeech;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) NSString *currentSpeech;

@end

#define theAppDelegate	((GreatTeleprompterAppDelegate *)[UIApplication sharedApplication].delegate)