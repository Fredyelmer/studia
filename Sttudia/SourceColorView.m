//
//  SourceColorView.m
//  Sttudia
//
//  Created by Fredy Arias on 18/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "SourceColorView.h"

@implementation SourceColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark	UIView overrides
- (void) drawRect: (CGRect) rect
{
	[super drawRect: rect];
	
	if (self.enabled && self.trackingInside) {
		CGRect bounds = [self bounds];
		
		[[UIColor whiteColor] set];
		CGContextStrokeRectWithWidth(UIGraphicsGetCurrentContext(),
		                             CGRectInset(bounds, 1, 1), 2);
		
		[[UIColor blackColor] set];
		UIRectFrame(CGRectInset(bounds, 2, 2));
	}
}

#pragma mark	UIControl overrides
- (void) setTrackingInside: (BOOL) newValue
{
	if (newValue != _trackingInside) {
		_trackingInside = newValue;
		[self setNeedsDisplay];
	}
}

- (BOOL) beginTrackingWithTouch: (UITouch*) touch
                      withEvent: (UIEvent*) event
{
	if (self.enabled) {
		self.trackingInside = YES;
        NSLog(@"teste");
		
		return [super beginTrackingWithTouch: touch withEvent: event];
	}
	else {
		return NO;
	}
}

- (BOOL) continueTrackingWithTouch: (UITouch*) touch withEvent: (UIEvent*) event
{
	BOOL isTrackingInside = CGRectContainsPoint([self bounds], [touch locationInView: self]);
	
	self.trackingInside = isTrackingInside;
	
	return [super continueTrackingWithTouch: touch withEvent: event];
}

- (void) endTrackingWithTouch: (UITouch*) touch withEvent: (UIEvent*) event
{
	self.trackingInside = NO;
	
	[super endTrackingWithTouch: touch withEvent: event];
}

- (void) cancelTrackingWithEvent: (UIEvent*) event
{
	self.trackingInside = NO;
	
	[super cancelTrackingWithEvent: event];
}

@end
