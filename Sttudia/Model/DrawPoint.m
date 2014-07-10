//
//  DrawPoint.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 10/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "DrawPoint.h"

@implementation DrawPoint

- (id) initWithPoint: (CGPoint)initialPoint : (CGPoint)finalPoint : (NSTimeInterval)interval
{
    self = [super init];
    
    if (self) {
        self.initialPoint = initialPoint;
        self.finalPoint = finalPoint;
        self.interval = interval;
    }
    
    return self;
}

@end
