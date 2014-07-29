//
//  CorUIButton.m
//  Sttudia
//
//  Created by Fredy Arias on 01/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "CorUIButton.h"

@implementation CorUIButton
@synthesize state;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self initialise];
       // [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.state = NO;
        [self initialise];
        
       // [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)initialise
{
    self.layer.cornerRadius  = 10.0f;
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [[UIColor  blackColor] CGColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self initialise];
    CGRect bounds = [self bounds];
    
    [[UIColor whiteColor] set];
    //CGContextStrokeRectWithWidth(UIGraphicsGetCurrentContext(), CGRectInset(bounds, 1, 1), 2);
    
    [[UIColor blackColor] set];
    //UIRectFrame(CGRectInset(bounds, 2, 2));
}
*/
- (void) buttonPressed
{
    self.layer.borderColor = [[UIColor  yellowColor] CGColor];
}

@end

