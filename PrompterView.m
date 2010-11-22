//
//  PrompterView.m
//  GreatTeleprompter
//
//  Created by Scott Means on 6/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PrompterView.h"


@implementation PrompterView

@synthesize theSpeech, paused, currentTouches;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    return self;
}

- (void)awakeFromNib
{
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	scrollVelocity = (1/TICK_INTERVAL);
	self.currentTouches = [[NSMutableSet alloc] initWithCapacity:5];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(c, 1.0, 1.0, 1.0, 1.0);
	
	CGRect rc = CGRectMake(rect.origin.x, rect.origin.y - (speechOffset * (baseSize.width/self.bounds.size.width)), rect.size.width, rect.size.height + speechOffset);
	
	[theSpeech drawInRect:rc withFont:self.currentFont];
}

- (void)setTheSpeech:(NSString *)newSpeech
{
	[theSpeech release];
	theSpeech = [newSpeech retain];
	
	tickTimer = [NSTimer scheduledTimerWithTimeInterval:TICK_INTERVAL target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
	
	speechOffset = 0.0;
	baseSize = [theSpeech sizeWithFont:self.currentFont constrainedToSize:CGSizeMake(self.bounds.size.width, INFINITY)];
	
	[self setNeedsDisplay];
}

- (void)layoutSubviews
{
	[self setNeedsDisplay];
}

- (void)timerTick:(NSTimer*)theTimer
{
	if (round(scrollVelocity) != 0) {
		speechOffset += scrollVelocity * TICK_INTERVAL;
		
		if (speechOffset < 0) {
			speechOffset = 0;
			self.paused = true;
		}
		
		float maxOffset = baseSize.height - self.bounds.size.height;
		
		if (speechOffset > maxOffset) {
			speechOffset = maxOffset;
			self.paused = true;
		}
		
		[self setNeedsDisplay];
	}
	
	if (paused) {
		scrollVelocity *= .91;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	
	[currentTouches unionSet:touches];

	[self initTouchInfo];
	
	NSLog(@"touchesBegan");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([currentTouches count] == 1) {
		UITouch *t = [touches anyObject];
		
		CGPoint newTouchPos = [t locationInView:self];
		
		speechOffset -= newTouchPos.y - lastTouchPos.y;
		
		CFTimeInterval now = CACurrentMediaTime();
		
		scrollVelocity = (lastTouchPos.y - newTouchPos.y)/(now - lastTouchTime);
		
		lastTouchPos = newTouchPos;
		lastTouchTime = now;
		
		[self setNeedsDisplay];
	} if ([currentTouches count] == 2) {
		NSLog(@"touchGap delta: %f", self.touchGap-baseTouchGap);
		[self setNeedsDisplay];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[currentTouches minusSet:touches];
	
	[self initTouchInfo];
	
	NSLog(@"touchesEnded");
}

- (float)touchGap
{
	if ([currentTouches count] == 2) {
		UITouch *t1 = [[currentTouches allObjects] objectAtIndex:0];
		CGPoint p1 = [t1 locationInView:self];
		UITouch *t2 = [[currentTouches allObjects] objectAtIndex:1];
		CGPoint p2 = [t2 locationInView:self];
		
		float dx = p2.x - p1.x;
		float dy = p2.y - p1.y;
		
		return sqrt(dx*dx + dy*dy);
	}
	
	return 0;
}

- (UIFont *)currentFont
{
	if (self.touchGap) {
		float newFontSize = DEFAULT_FONT_SIZE+(self.touchGap-baseTouchGap)/2;
		newFontSize = MIN(MAX_FONT_SIZE, MAX(newFontSize, MIN_FONT_SIZE));
		
		return [UIFont systemFontOfSize:newFontSize];
	} else {
		return [UIFont systemFontOfSize:DEFAULT_FONT_SIZE];
	}
}

- (void)initTouchInfo
{
	if ([currentTouches count] == 1) {
		UITouch *t = [currentTouches anyObject];
		
		lastTouchPos = [t locationInView:self];
		lastTouchTime = CACurrentMediaTime();
	} else if ([currentTouches count] == 2) {
		baseTouchGap = self.touchGap;
	}
}

- (void)setPaused:(_Bool)newPaused
{
	scrollVelocity = newPaused ? 0 : (1/TICK_INTERVAL);
	paused = newPaused;
}

- (void)dealloc {
    [super dealloc];
}


@end
