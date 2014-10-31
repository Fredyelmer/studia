//
//  MessageDelete.m
//  Sttudia
//
//  Created by Fredy Arias on 29/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageDelete.h"

@implementation MessageDelete

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
