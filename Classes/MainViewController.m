//
//  MainViewController.m
//  GreatTeleprompter
//
//  Created by Scott Means on 4/4/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MainViewController.h"
#import "GreatTeleprompterAppDelegate.h"
#import "DismissViewController.h"


@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(appWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
	[nc addObserver:self selector:@selector(appWillSuspend:) name:UIApplicationWillResignActiveNotification object:nil];
	
	prompter.theSpeech = theAppDelegate.currentSpeech;
}

- (void)viewDidAppear:(BOOL)animated
{
	prompter.theSpeech = theAppDelegate.currentSpeech;
	
	if (!hasInitialized) {
		prompter.speechOffset = [[NSUserDefaults standardUserDefaults] floatForKey:SPEECHOFFSET_KEY];
		hasInitialized = true;
	}
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
	
}

- (void)appWillTerminate:(NSNotification *)notification
{
	[[NSUserDefaults standardUserDefaults] setFloat:prompter.speechOffset forKey:SPEECHOFFSET_KEY];
}

- (void)appWillSuspend:(NSNotification *)notification
{
	prompter.paused = true;
	playButton.hidden = false;
}

- (IBAction)showInfo {
	DismissViewController *dmc = [[DismissViewController alloc] init];
	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:dmc];
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	[nc pushViewController:controller animated:NO];
	
	nc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:nc animated:YES];
	
	[controller release];
	[nc release];
	[dmc release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	prompter.paused = true;
	playButton.hidden = false;
}

- (IBAction)playClicked
{
	prompter.paused = false;
	playButton.hidden = true;
}

- (void)dealloc {
    [super dealloc];
}


@end
