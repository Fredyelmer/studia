//
//  ColorSquarePicker.m
//  Sttudia
//
//  Created by Fredy Arias on 18/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ColorSquarePicker.h"
#import "ColorIndicatorView.h"
#import "HSBSupport.h"
#import "ColorSquareView.h"

@implementation ColorSquarePicker
{
    ColorIndicatorView* indicator;
    ColorSquareView*    colorSquare;
}

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
#define kContentInsetX 20
#define kContentInsetY 20

#define kIndicatorSize 24

#pragma mark	Appearance
- (void) setIndicatorColor
{
	if (indicator == nil)
		return;
	
    UIColor *color = [UIColor colorWithHue: self.hue saturation: self.value.x brightness: self.value.y alpha: 1.0f];
	indicator.color = color;
    [colorSquare setHue:self.hue];
}

- (NSString*) spokenValue
{
	return [NSString stringWithFormat: @"%d%% saturation, %d%% brightness",
            (int) (self.value.x * 100), (int) (self.value.y * 100)];
}

- (void) layoutSubviews
{
    CGFloat indicatorSize = self.bounds.size.height/6;
	if (indicator == nil)
    {
        CGRect rect = [self bounds];
        rect.size.width = rect.size.width - indicatorSize;
        rect.size.height = rect.size.height - indicatorSize;
        rect.origin.x = rect.origin.x + indicatorSize/2;
        rect.origin.y = rect.origin.y + indicatorSize/2;
        
        colorSquare = [[ColorSquareView alloc] initWithFrame:rect];
        [self addSubview:colorSquare];
        
		CGRect indicatorRect = { CGPointZero, { indicatorSize, indicatorSize } };
		indicator = [[ColorIndicatorView alloc] initWithFrame: indicatorRect];
        
        
		[self addSubview: indicator];
	}
	
	[self setIndicatorColor];
	
	CGFloat indicatorX = indicatorSize/2 + (self.value.x * (self.bounds.size.width - indicatorSize));
	CGFloat indicatorY = self.bounds.size.height - indicatorSize/2 - (self.value.y * (self.bounds.size.height - indicatorSize));
	
	indicator.center = CGPointMake(indicatorX, indicatorY);
}

#pragma mark	Properties
- (void) setHue: (float) newValue
{
	if (newValue != _hue) {
		_hue = newValue;
		
		[self setIndicatorColor];
	}
}

- (void) setValue: (CGPoint) newValue
{
	if (!CGPointEqualToPoint(newValue, _value)) {
		_value = newValue;
		
		[self sendActionsForControlEvents: UIControlEventValueChanged];
		[self setNeedsLayout];
	}
}

#pragma mark	Tracking
- (void) trackIndicatorWithTouch: (UITouch*) touch
{
	CGRect bounds = self.bounds;
	
	CGPoint touchValue;
	
	touchValue.x = ([touch locationInView: self].x - kContentInsetX)
    / (bounds.size.width - 2 * kContentInsetX);
	
	touchValue.y = ([touch locationInView: self].y - kContentInsetY)
    / (bounds.size.height - 2 * kContentInsetY);
	
    HSBSupport *sup = [[HSBSupport alloc] init];
	touchValue.x = [sup pin:0.0f value:touchValue.x maxValue:1.0f];
	touchValue.y = 1.0f - [sup pin:0.0f value:touchValue.y maxValue:1.0f];
	
	self.value = touchValue;
}

- (BOOL) beginTrackingWithTouch: (UITouch*) touch
                      withEvent: (UIEvent*) event
{
	[self trackIndicatorWithTouch: touch];
	return YES;
}

- (BOOL) continueTrackingWithTouch: (UITouch*) touch
                         withEvent: (UIEvent*) event
{
	[self trackIndicatorWithTouch: touch];
	return YES;
}

@end
