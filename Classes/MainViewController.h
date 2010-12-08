//
//  MainViewController.h
//  GreatTeleprompter
//
//  Created by Scott Means on 4/4/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FlipsideViewController.h"
#import "PrompterView.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	IBOutlet PrompterView *prompter;
	IBOutlet UIButton *playButton;
}

- (IBAction)showInfo;
- (IBAction)playClicked;
- (void)appWillTerminate:(NSNotification *)notification;

@end

#define SPEECHOFFSET_KEY	@"SpeechOffset"