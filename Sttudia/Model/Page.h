//
//  Page.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 22/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject

@property (strong, nonatomic) UIImage *drawView;
@property (strong, nonatomic) NSMutableArray* arrayImage;
@property (strong, nonatomic) NSMutableArray* arrayText;
@property (strong, nonatomic) NSMutableArray* arrayUndo;
@property (strong, nonatomic) NSMutableArray* arrayRedo;
@property (strong, nonatomic) UIImage *backGroundImage;

- (id)initWithElements : (UIImage *)drawView : (NSMutableArray *)arrayImage : (NSMutableArray *)arrayText : (NSMutableArray *)arrayUndo : (NSMutableArray *)arrayRedo : (UIImage *)bacKGroundImage;

@end
