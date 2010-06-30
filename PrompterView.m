//
//  PrompterView.m
//  GreatTeleprompter
//
//  Created by Scott Means on 6/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PrompterView.h"


@implementation PrompterView

@synthesize theSpeech;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    return self;
}

- (void)awakeFromNib
{
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(c, 1.0, 1.0, 1.0, 1.0);
	
	CGRect rc = CGRectMake(rect.origin.x, rect.origin.y - speechOffset, rect.size.width, rect.size.height + speechOffset);
	
	[theSpeech drawInRect:rc withFont:[UIFont systemFontOfSize:36.0]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	speechOffset += 10.0;
	[self setNeedsDisplay];
}

- (void)setTheSpeech:(NSString *)newSpeech
{
	[theSpeech release];
	theSpeech = [newSpeech retain];
	
	speechOffset = 0.0;
	
	[self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}


@end
