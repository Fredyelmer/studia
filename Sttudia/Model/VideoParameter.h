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
@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UITextField* text;
@property (assign, nonatomic) BOOL isDrawing;
@property (assign, nonatomic) BOOL imageAdded;
@property (assign, nonatomic) BOOL textAdded;
@property (assign, nonatomic) BOOL pageChanged;
@property (assign, nonatomic) BOOL isTaskTerminated;
@property (assign, nonatomic) NSInteger pageNumber;
@property (assign, nonatomic) NSInteger maxPageNumber;
@property (assign, nonatomic) BOOL isForward;

- (id) initWithParameter: (CGPoint)initialPoint : (CGPoint)finalPoint : (NSTimeInterval)interval : (int)typeChange : (float) red : (float) green : (float) blue : (float) brush;
- (id) initWithImage:(UIImageView *)image;
- (id) initWithText: (UITextField *)text;
- (id) initWithNumberOfPage: (NSInteger)pageNumber : (NSInteger)maxPageNumber : (BOOL)isForward;

@end
