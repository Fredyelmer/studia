//
//  BackGroundImage.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 26/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "BackGroundImage.h"

@implementation BackGroundImage

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    
    if (self) {
        self.image = image;
    }
    
    return self;
}

@end
