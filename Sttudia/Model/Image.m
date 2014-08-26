//
//  Image.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 16/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "Image.h"

@implementation Image

- (id)initWithImage : (UIImageView *)imageView : (CGPoint)imagePosition : (CGRect)imageBounds : (CGFloat)angle : (UIImage*) canvas : (CGAffineTransform) imageTransform
{
    self = [super init];
    
    if (self) {
        self.imageView = imageView;
        self.imageBounds = imageBounds;
        self.imageCenter = imagePosition;
        self.imageAngle = angle;
        self.canvasImage = canvas;
        self.imageTransform  = imageTransform;
    }
    
    return self;
}
@end
