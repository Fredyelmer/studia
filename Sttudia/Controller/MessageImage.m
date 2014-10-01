//
//  MessageImage.m
//  Sttudia
//
//  Created by Fredy Arias on 18/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageImage.h"

@implementation MessageImage

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.image = [decoder decodeObjectForKey:@"image"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.image forKey:@"image"];
}

@end
