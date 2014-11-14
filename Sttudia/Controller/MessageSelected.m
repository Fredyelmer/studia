//
//  MessageSelected.m
//  Sttudia
//
//  Created by Fredy Arias on 13/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageSelected.h"

@implementation MessageSelected

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.tag = [decoder decodeIntegerForKey:@"tag"];
        self.isImage = [decoder decodeBoolForKey:@"isImage"];
        self.isSelected = [decoder decodeBoolForKey:@"isSelected"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.tag forKey:@"tag"];
    [encoder encodeBool:self.isImage forKey:@"isImage"];
    [encoder encodeBool:self.isSelected forKey:@"isSelected"];
}

@end
