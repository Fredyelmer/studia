//
//  MessageRotate.m
//  Sttudia
//
//  Created by Fredy Arias on 16/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageRotate.h"

@implementation MessageRotate

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.tag = [decoder decodeIntegerForKey:@"tag"];
        self.rotation = [decoder decodeFloatForKey:@"rotation"];
        self.isImage = [decoder decodeBoolForKey:@"isImage"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.tag forKey:@"tag"];
    [encoder encodeFloat:self.rotation forKey:@"rotation"];
    [encoder encodeBool:self.isImage forKey:@"isImage"];
}

@end
