//
//  ColorBarView.m
//  Sttudia
//
//  Created by Fredy Arias on 17/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ColorBarView.h"
#import "HSBSupport.h"

@implementation ColorBarView

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

static CGImageRef createContentImage()
{
    HSBSupport *support = [[HSBSupport alloc] init];
	float hsv[] = { 0.0f, 1.0f, 1.0f };
	return [support createHSVBarContentImage:InfComponentIndexHue hsv: hsv];
}

- (void) drawRect: (CGRect) rect
{
	CGImageRef image = createContentImage();
	
	if (image) {
		CGContextRef context = UIGraphicsGetCurrentContext();
		
		CGContextDrawImage(context, [self bounds], image);
		
        //estava dando erro de analysing
		//CGImageRelease(image);
	}
}

@end
