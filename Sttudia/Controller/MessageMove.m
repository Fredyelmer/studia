//
//  MessageMove.m
//  Sttudia
//
//  Created by Fredy Arias on 15/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageMove.h"

@implementation MessageMove

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.point = [decoder decodeObjectForKey:@"point"];
        self.isImage = [decoder decodeBoolForKey:@"isImage"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.point forKey:@"point"];
    [encoder encodeBool:self.isImage forKey:@"isImage"];
}

@end
