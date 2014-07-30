//
//  ColorPickerView.m
//  Sttudia
//
//  Created by Fredy Arias on 17/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ColorPickerView.h"

@implementation ColorPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.isEnable = NO;
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

@end
