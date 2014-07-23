//
//  ColorSquareView.m
//  Sttudia
//
//  Created by Fredy Arias on 17/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ColorSquareView.h"
#import "HSBSupport.h"

@implementation ColorSquareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"aqui");
        [self updateContent];
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

- (void) drawRect: (CGRect) rect
{
    NSLog(@"aca");
    //self.hue = 0.2;
//    HSBSupport *support = [[HSBSupport alloc] init];
//	CGImageRef imageRef = [support createSaturationBrightnessSquareContentImageWithHue:(self.hue * 360)];
//	self.image = [UIImage imageWithCGImage: imageRef];
//	CGImageRelease(imageRef);
}

- (void) updateContent
{
    HSBSupport *support = [[HSBSupport alloc] init];
	CGImageRef imageRef = [support createSaturationBrightnessSquareContentImageWithHue:(self.hue * 360)];
	self.image = [UIImage imageWithCGImage: imageRef];
	CGImageRelease(imageRef);
}

#pragma mark	Properties
- (void) setHue: (float) value
{
	if (value != _hue || self.image == nil) {
		_hue = value;
		
		[self updateContent];
	}
}

@end
