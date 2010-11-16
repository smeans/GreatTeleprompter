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

@synthesize theSpeech, paused;

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
}

- (void)drawRect:(CGRect)rect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(c, 1.0, 1.0, 1.0, 1.0);
	
	CGRect rc = CGRectMake(rect.origin.x, rect.origin.y - (speechOffset * (baseSize.width/self.bounds.size.width)), rect.size.width, rect.size.height + speechOffset);
	
	[theSpeech drawInRect:rc withFont:[UIFont systemFontOfSize:36.0]];
}

- (void)setTheSpeech:(NSString *)newSpeech
{
	[theSpeech release];
	theSpeech = [newSpeech retain];
	
	tickTimer = [NSTimer scheduledTimerWithTimeInterval:TICK_INTERVAL target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
	
	speechOffset = 0.0;
	baseSize = [theSpeech sizeWithFont:[UIFont systemFontOfSize:36.0] constrainedToSize:CGSizeMake(self.bounds.size.width, INFINITY)];
	
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
	
	UITouch *t = [touches anyObject];
	
	lastTouchPos = [t locationInView:self];
	lastTouchTime = CACurrentMediaTime();
	
	NSLog(@"touchesBegan");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *t = [touches anyObject];
	
	CGPoint newTouchPos = [t locationInView:self];
	
	speechOffset -= newTouchPos.y - lastTouchPos.y;
	
	CFTimeInterval now = CACurrentMediaTime();
	
	scrollVelocity = (lastTouchPos.y - newTouchPos.y)/(now - lastTouchTime);
	
	lastTouchPos = newTouchPos;
	lastTouchTime = now;
	
	[self setNeedsLayout];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesEnded");
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
