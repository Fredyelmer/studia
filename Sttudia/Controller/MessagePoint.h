//
//  MessagePoint.h
//  Sttudia
//
//  Created by Fredy Arias on 16/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageBoard.h"

@interface MessagePoint : MessageBoard

@property (nonatomic, strong) NSString *actionName;

@property (nonatomic, strong) NSValue *point;

@end
