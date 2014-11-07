//
//  MessageMove.h
//  Sttudia
//
//  Created by Fredy Arias on 15/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageBoard.h"

@interface MessageMove : MessageBoard

@property (nonatomic) NSInteger tag;
@property (nonatomic, strong) NSValue *point;
@property (nonatomic) BOOL isImage;

@end
