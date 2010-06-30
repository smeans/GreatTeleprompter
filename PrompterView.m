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
	
	[theSpeech drawInRect:self.bounds withFont:[UIFont systemFontOfSize:36.0]];
}

- (void)setTheSpeech:(NSString *)newSpeech
{
	[theSpeech release];
	theSpeech = [newSpeech retain];
	
	[self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}


@end
