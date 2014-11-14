//
//  MessageRotate.m
//  Sttudia
//
//  Created by Fredy Arias on 16/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageTransform.h"

@implementation MessageTransform

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.tag = [decoder decodeIntegerForKey:@"tag"];
        self.isImage = [decoder decodeBoolForKey:@"isImage"];
        self.transform = [decoder decodeCGAffineTransformForKey:@"transform"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.tag forKey:@"tag"];
    [encoder encodeBool:self.isImage forKey:@"isImage"];
    [encoder encodeCGAffineTransform:self.transform forKey:@"transform"];
}

@end
