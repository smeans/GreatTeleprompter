//
//  PrompterView.h
//  GreatTeleprompter
//
//  Created by Scott Means on 6/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PrompterView : UIView {
	NSString *theSpeech;
	float speechOffset;
	NSTimer *tickTimer;
	bool paused;
}

@property (nonatomic, retain) NSString *theSpeech;
@property (nonatomic, assign) bool paused;

- (void)timerTick:(NSTimer*)theTimer;

#define TICK_INTERVAL	.05
@end
