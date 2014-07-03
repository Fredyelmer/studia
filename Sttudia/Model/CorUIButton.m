//
//  CorUIButton.m
//  Sttudia
//
//  Created by Fredy Arias on 01/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "CorUIButton.h"

@implementation CorUIButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialise];
       // [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialise];
       // [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)initialise
{
    self.layer.cornerRadius  = 10.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor  blackColor] CGColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) buttonPressed
{
    self.layer.borderColor = [[UIColor  yellowColor] CGColor];
    NSLog(@"press");
}

@end

