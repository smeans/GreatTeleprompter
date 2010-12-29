//
//  GreatTeleprompterAppDelegate.m
//  GreatTeleprompter
//
//  Created by Scott Means on 4/4/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "GreatTeleprompterAppDelegate.h"
#import "MainViewController.h"

@implementation GreatTeleprompterAppDelegate


@synthesize window;
@synthesize mainViewController;
@synthesize currentSpeechIndex;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    	
	speeches = [[NSMutableArray alloc] init];
	
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
	
	return YES;
}

- (NSString *)currentSpeech
{
	return [speeches objectAtIndex:currentSpeechIndex];
}

- (void)setCurrentSpeech:(NSString *)newSpeech {
	if (currentSpeechIndex >= 0 && currentSpeechIndex < [speeches count]) {
		[speeches removeObjectAtIndex:currentSpeechIndex];
		[speeches insertObject:newSpeech atIndex:currentSpeechIndex];
	} else {
		[speeches addObject:newSpeech];
	}
}

- (NSArray *)speeches
{
	return speeches;
}

- (void)dealloc {
	[speeches release];
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
