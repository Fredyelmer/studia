//
//  ColorBarPicker.m
//  Sttudia
//
//  Created by Fredy Arias on 17/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ColorBarPicker.h"
#import "ColorIndicatorView.h"
#import "ColorBarView.h"
#import "HSBSupport.h"

#define kContentInsetX 20

@implementation ColorBarPicker
{
	ColorIndicatorView* indicator;
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

#pragma mark	Drawing
- (void) layoutSubviews
{
    CGFloat indicatorSize = self.bounds.size.height/1.5;
	if (indicator == nil)
    {
        CGRect rect = [self bounds];
        rect.size.width = rect.size.width - indicatorSize;
        rect.origin.x = rect.origin.x + indicatorSize/2;
        
        ColorBarView *colorBar = [[ColorBarView alloc] initWithFrame:rect];
        [self addSubview:colorBar];
        
		
		indicator = [[ColorIndicatorView alloc] initWithFrame: CGRectMake(0, 0, indicatorSize, indicatorSize)];
		[self addSubview: indicator];
	}
	
	indicator.color = [UIColor colorWithHue: self.value saturation: 1.0f brightness: 1.0f alpha: 1.0f];
	
	CGFloat indicatorLoc = indicatorSize/2 + (self.value * (self.bounds.size.width - indicatorSize));
	indicator.center = CGPointMake(indicatorLoc, CGRectGetMidY(self.bounds));
}

#pragma mark	Properties
- (void) setValue: (float) newValue
{
    NSLog(@"aca hue");
	if (newValue != _value) {
		_value = newValue;
		
		[self sendActionsForControlEvents: UIControlEventValueChanged];
		[self setNeedsLayout];
	}
}

#pragma mark	Tracking
- (void) trackIndicatorWithTouch: (UITouch*) touch
{
	float percent = ([touch locationInView: self].x )
    / (self.bounds.size.width);
	
    HSBSupport *sup = [[HSBSupport alloc] init];
	self.value = [sup pin:0.0f value:percent maxValue:1.0f];
    NSLog(@"value: %f",self.value);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	[self trackIndicatorWithTouch: touch];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	[self trackIndicatorWithTouch: touch];
}

#pragma mark	Accessibility
- (UIAccessibilityTraits) accessibilityTraits
{
	UIAccessibilityTraits t = super.accessibilityTraits;
	
	t |= UIAccessibilityTraitAdjustable;
	
	return t;
}

- (void) accessibilityIncrement
{
	float newValue = self.value + 0.05;
	
	if (newValue > 1.0)
		newValue -= 1.0;
    
	self.value = newValue;
}

- (void) accessibilityDecrement
{
	float newValue = self.value - 0.05;
	
	if (newValue < 0)
		newValue += 1.0;
	
	self.value = newValue;
}

- (NSString*) accessibilityValue
{
	return [NSString stringWithFormat: @"%d degrees hue", (int) (self.value * 360.0)];
}

@end
