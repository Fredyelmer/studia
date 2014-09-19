//
//  MessageBrush.m
//  Sttudia
//
//  Created by Fredy Arias on 18/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageBrush.h"

@implementation MessageBrush

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.point = [decoder decodeObjectForKey:@"point"];
        self.actionName = [decoder decodeObjectForKey:@"name"];
        self.color = [decoder decodeObjectForKey:@"color"];
        self.thickness = [decoder decodeFloatForKey:@"thickness"];
        self.isEraser = [decoder decodeBoolForKey:@"isEraser"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.point forKey:@"point"];
    [encoder encodeObject:self.actionName forKey:@"name"];
    [encoder encodeObject:self.color forKey:@"color"];
    [encoder encodeFloat:self.thickness forKey:@"thickness"];
    [encoder encodeBool:self.isEraser forKey:@"isEraser"];
}

@end
