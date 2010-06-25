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
@synthesize currentSpeech;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    	
	currentSpeech = [[NSString stringWithContentsOfFile:@"currentSpeech.txt" encoding:NSUTF8StringEncoding error:nil] retain];
	
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)setCurrentSpeech:(NSString *)newSpeech {
	[currentSpeech release];
	
	currentSpeech = [newSpeech retain];
	
	[newSpeech writeToFile:@"currentSpeech.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
