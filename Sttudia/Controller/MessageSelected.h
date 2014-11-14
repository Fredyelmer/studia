//
//  MessageSelected.h
//  Sttudia
//
//  Created by Fredy Arias on 13/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageBoard.h"

@interface MessageSelected : MessageBoard

@property (nonatomic) NSInteger tag;
@property (nonatomic) BOOL isImage;
@property (nonatomic) BOOL isSelected;

@end
