//
//  VideoParameter.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 10/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoParameter : NSObject

@property (assign, nonatomic) CGPoint initialPoint;
@property (assign, nonatomic) CGPoint finalPoint;
@property (assign, nonatomic) NSTimeInterval interval;
@property (assign, nonatomic) CGFloat currentRed;
@property (assign, nonatomic) CGFloat currentGreen;
@property (assign, nonatomic) CGFloat currentBlue;
@property (assign, nonatomic) CGFloat currentBrush;
@property (assign, nonatomic) BOOL isDrawing;
@property (assign, nonatomic) BOOL imageAdded;
@property (assign, nonatomic) BOOL textAdded;
@property (assign, nonatomic) BOOL pageChanged;

- (id) initWithParameter: (CGPoint)initialPoint : (CGPoint)finalPoint : (NSTimeInterval)interval : (int)typeChange : (float) red : (float) green : (float) blue : (float) brush;

@end
