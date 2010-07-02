//
//  FlipsideViewController.m
//  GreatTeleprompter
//
//  Created by Scott Means on 4/4/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "GreatTeleprompterAppDelegate.h"
#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
	theSpeech.text = theAppDelegate.currentSpeech;
}


- (IBAction)done {
	[self.delegate flipsideViewControllerDidFinish:self];
	theAppDelegate.currentSpeech = theSpeech.text;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)dealloc {
    [super dealloc];
}


@end
