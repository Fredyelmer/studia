//
//  MessageBrush.h
//  Sttudia
//
//  Created by Fredy Arias on 18/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageBoard.h"
#import "Brush.h"

@interface MessageBrush : MessageBoard

@property (nonatomic, strong) NSString *actionName;
@property (nonatomic, strong) NSValue *point;
@property (nonatomic, strong) NSValue *previousPoint;
@property (nonatomic, strong) NSValue *previousPreviousPoint;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic) CGFloat thickness;
@property (nonatomic) BOOL isEraser;

@end
