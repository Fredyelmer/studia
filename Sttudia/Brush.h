//
//  Brush.h
//  Sttudia
//
//  Created by Fredy Arias on 01/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brush : NSObject

@property (nonatomic, strong) UIColor* color;
@property (nonatomic) CGFloat thickness;
@property (nonatomic) BOOL isEraser;

@end
