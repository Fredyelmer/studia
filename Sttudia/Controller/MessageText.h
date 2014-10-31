//
//  MessageTextField.h
//  Sttudia
//
//  Created by Fredy Arias on 18/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageBoard.h"

@interface MessageText : MessageBoard

@property (nonatomic) BOOL isHost;
@property (nonatomic) NSInteger tag;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) UIFont* font;
@property (nonatomic, strong) UIColor* color;

@end

