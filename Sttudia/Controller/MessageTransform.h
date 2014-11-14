//
//  MessageRotate.h
//  Sttudia
//
//  Created by Fredy Arias on 16/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageBoard.h"

@interface MessageTransform : MessageBoard

@property (nonatomic) NSInteger tag;
@property (nonatomic) CGAffineTransform transform;
@property (nonatomic) BOOL isImage;

@end
