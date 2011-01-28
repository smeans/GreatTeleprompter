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
	speeches = [[NSMutableArray alloc] initWithContentsOfFile:[self.docDir stringByAppendingPathComponent:@"speeches"]];
	
	if (!speeches) {
		speeches = [[NSMutableArray alloc] init];
	}
	
	if ([speeches count] <= 0) {
		NSString *path = [[NSBundle mainBundle] pathForResource:@"DefaultSpeech" ofType:@"txt"];
		[speeches addObject:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]];		
	} else {
		currentSpeechIndex = [[NSUserDefaults standardUserDefaults] integerForKey:CURRENTSPEECHINDEX_KEY];
	}
	
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
	if (currentSpeechIndex >= 0 && currentSpeechIndex < [speeches count]) {
		return [speeches objectAtIndex:currentSpeechIndex];
	} else {
		return @"";
	}
}

- (void)setCurrentSpeech:(NSString *)newSpeech {
	if (currentSpeechIndex >= 0 && currentSpeechIndex < [speeches count]) {
		[speeches removeObjectAtIndex:currentSpeechIndex];
		[speeches insertObject:newSpeech atIndex:currentSpeechIndex];
	} else {
		[speeches addObject:newSpeech];
	}
	
	[speeches writeToFile:[self.docDir stringByAppendingPathComponent:@"speeches"] atomically:YES];
}

- (void)setCurrentSpeechIndex:(int)newIndex
{
	currentSpeechIndex = newIndex;
	
	[[NSUserDefaults standardUserDefaults] setInteger:currentSpeechIndex forKey:CURRENTSPEECHINDEX_KEY];
}

- (void)deleteCurrentSpeech
{
	if (currentSpeechIndex < 0 || currentSpeechIndex >= [speeches count]) {
		return;
	}
	
	[speeches removeObjectAtIndex:currentSpeechIndex];
	[speeches writeToFile:[self.docDir stringByAppendingPathComponent:@"speeches"] atomically:YES];
	
	self.currentSpeechIndex = MIN(self.currentSpeechIndex, [speeches count]-1);
}

- (NSString *)docDir
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
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
