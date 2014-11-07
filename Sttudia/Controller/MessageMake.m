//
//  MessageMake.m
//  Sttudia
//
//  Created by Fredy Arias on 03/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageMake.h"

@implementation MessageMake

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.tag = [decoder decodeIntegerForKey:@"tag"];
        self.isImage = [decoder decodeBoolForKey:@"isImage"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.tag forKey:@"tag"];
    [encoder encodeBool:self.isImage forKey:@"isImage"];
}

@end
