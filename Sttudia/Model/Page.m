//
//  Page.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 22/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "Page.h"

@implementation Page

- (id)initWithElements : (UIImage *)drawView : (NSMutableArray *)arrayImage : (NSMutableArray *)arrayText
{
    self = [super init];
    
    if(self)
    {
        self.drawView = drawView;
        self.arrayImage = arrayImage;
        self.arrayText = arrayText;
    }
    
    return self;
}

@end
