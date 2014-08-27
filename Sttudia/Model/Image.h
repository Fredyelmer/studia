//
//  Image.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 16/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

@property (strong, nonatomic) UIImageView* imageView;
@property (assign, nonatomic) CGPoint imageCenter;
@property (assign, nonatomic) CGRect imageBounds;
@property (assign, nonatomic) CGFloat imageAngle;
@property (strong, nonatomic) UIImage* canvasImage;
@property (assign, nonatomic) CGAffineTransform imageTransform;

- (id)initWithImage : (UIImageView *)imageView : (CGPoint)imagePosition : (CGRect)imageBounds : (CGFloat)angle : (UIImage*) canvas : (CGAffineTransform) imageTransform;

@end
