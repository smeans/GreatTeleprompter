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
	CGSize baseSize;
	NSTimer *tickTimer;
	bool paused;
	CGPoint lastTouchPos;
	float baseTouchGap;
	CFTimeInterval lastTouchTime;
	float scrollVelocity;
	NSMutableSet *currentTouches;
}

@property (nonatomic, retain) NSString *theSpeech;
@property (nonatomic, assign) bool paused;
@property (nonatomic, retain) NSMutableSet *currentTouches;
@property (nonatomic, readonly) float touchGap;
@property (nonatomic, readonly) UIFont *currentFont;

- (void)timerTick:(NSTimer*)theTimer;
- (void)initTouchInfo;

#define TICK_INTERVAL	.05
@end
