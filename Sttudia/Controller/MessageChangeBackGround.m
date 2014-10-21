//
//  MessageChangeBackGround.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 21/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageChangeBackGround.h"

@implementation MessageChangeBackGround

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        _nameImage = [decoder decodeObjectForKey:@"nameImage"];
        _image = [decoder decodeObjectForKey:@"image"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_nameImage forKey:@"nameImage"];
    [encoder encodeObject:_image forKey:@"image"];
}

@end
