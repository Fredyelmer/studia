//
//  MessageRezise.m
//  Sttudia
//
//  Created by Fredy Arias on 15/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageResize.h"

@implementation MessageResize

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.scale = [decoder decodeFloatForKey:@"scale"];
        self.isImage = [decoder decodeBoolForKey:@"isImage"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeFloat:self.scale forKey:@"scale"];
    [encoder encodeBool:self.isImage forKey:@"isImage"];
}

@end
