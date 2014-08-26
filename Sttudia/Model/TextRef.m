//
//  TextRef.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 22/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "TextRef.h"

@implementation TextRef

- (id)initWithText : (UITextField *)textField : (CGPoint)textCenter : (UIImage*) canvas : (CGAffineTransform) textTransform : (NSString *) textString : (NSString *) textFontName : (int) size : (UIColor*) color
{
    self = [super init];
    
    if (self){
        self.textField = textField;
        self.textCenter = textCenter;
        self.canvasImage = canvas;
        self.textTransform = textTransform;
        self.textString = textString;
        self.textFontName = textFontName;
        self.textFontSize = size;
        self.textColor = color;
    }
    return self;
}
@end
