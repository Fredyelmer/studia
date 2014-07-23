//
//  ColorIndicatorView.m
//  Sttudia
//
//  Created by Fredy Arias on 17/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ColorIndicatorView.h"

@implementation ColorIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
		self.userInteractionEnabled = NO;
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

- (void) setColor: (UIColor*) newColor
{
	if (![_color isEqual: newColor]) {
		_color = newColor;
		
		[self setNeedsDisplay];
	}
}

- (void) drawRect: (CGRect) rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGPoint center = { CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) };
	CGFloat radius = CGRectGetMidX(self.bounds);
	
	// Fill it:
	
	CGContextAddArc(context, center.x, center.y, radius - 1.0f, 0.0f, 2.0f * (float) M_PI, YES);
	[self.color setFill];
	CGContextFillPath(context);
	
	// Stroke it (black transucent, inner):
	
	CGContextAddArc(context, center.x, center.y, radius - 1.0f, 0.0f, 2.0f * (float) M_PI, YES);
	CGContextSetGrayStrokeColor(context, 0.0f, 0.5f);
	CGContextSetLineWidth(context, 2.0f);
	CGContextStrokePath(context);
	
	// Stroke it (white, outer):
	
	CGContextAddArc(context, center.x, center.y, radius - 2.0f, 0.0f, 2.0f * (float) M_PI, YES);
	CGContextSetGrayStrokeColor(context, 1.0f, 1.0f);
	CGContextSetLineWidth(context, 2.0f);
	CGContextStrokePath(context);
}

@end
