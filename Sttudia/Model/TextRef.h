//
//  TextRef.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 22/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextRef : NSObject

@property (strong, nonatomic) UITextField* textField;
@property (assign, nonatomic) CGPoint textCenter;
@property (strong, nonatomic) UIImage* canvasImage;
@property (assign, nonatomic) CGAffineTransform textTransform;
@property (strong, nonatomic) NSString *textString;
@property (strong, nonatomic) NSString *textFontName;
@property (assign, nonatomic) int textFontSize;
@property (strong, nonatomic) UIColor *textColor;

- (id)initWithText : (UITextField *)textField : (CGPoint)textCenter : (UIImage*) canvas : (CGAffineTransform) textTransform : (NSString *) textString : (NSString *) textFontName : (int) size : (UIColor*) color;

@end
