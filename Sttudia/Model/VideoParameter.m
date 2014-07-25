//
//  DrawPoint.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 10/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "VideoParameter.h"

@implementation VideoParameter

- (id) initWithParameter: (CGPoint)initialPoint : (CGPoint)finalPoint : (NSTimeInterval)interval : (int)typeChange : (float) red : (float) green : (float) blue : (float) brush
{
    self = [super init];
    
    if (self) {
        self.initialPoint = initialPoint;
        self.finalPoint = finalPoint;
        self.interval = interval;
        self.currentRed = red;
        self.currentGreen = green;
        self.currentBlue = blue;
        self.currentBrush = brush;
        self.isTaskTerminated = NO;
        
        switch (typeChange) {
            case 0:
                self.isDrawing = YES;
                self.imageAdded = NO;
                self.textAdded = NO;
                self.pageChanged = NO;
                break;
            case 1:
                self.isDrawing = NO;
                self.imageAdded = YES;
                self.textAdded = NO;
                self.pageChanged = NO;
                break;
            case 2:
                self.isDrawing = NO;
                self.imageAdded = NO;
                self.textAdded = YES;
                self.pageChanged = NO;
                break;
            case 3:
                self.isDrawing = NO;
                self.imageAdded = NO;
                self.textAdded = NO;
                self.pageChanged = YES;
                break;
            default:
                break;
           }
    }
    return self;
}

- (id) initWithImage: (UIImageView *)image
{
    self = [super init];
    if (self) {
        
        self.imageView = image;
        self.isDrawing = NO;
        self.imageAdded = YES;
        self.textAdded = NO;
        self.pageChanged = NO;
    }
    return self;
}

- (id) initWithText: (UITextField *)text
{
    self = [super init];
    if (self) {
        
        self.isDrawing = NO;
        self.imageAdded = NO;
        self.textAdded = YES;
        self.pageChanged = NO;
        
    }
    return self;
}

- (id) initWithNumberOfPage: (NSInteger)pageNumber : (NSInteger)maxPageNumber : (BOOL)isForward
{
    self = [super init];
    if (self) {
        
        self.isDrawing = NO;
        self.imageAdded = NO;
        self.textAdded = NO;
        self.pageChanged = YES;
        self.pageNumber = pageNumber;
        self.maxPageNumber = maxPageNumber;
        self.isForward = isForward;
    }
    
    return self;
}

@end
