//
//  DrawPoint.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 10/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawPoint : NSObject

@property (assign, nonatomic) CGPoint initialPoint;
@property (assign, nonatomic) CGPoint finalPoint;
@property (assign, nonatomic) NSTimeInterval interval;

- (id) initWithPoint: (CGPoint)initialPoint : (CGPoint)finalPoint : (NSTimeInterval)interval;
@end
