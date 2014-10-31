//
//  MessageTextField.m
//  Sttudia
//
//  Created by Fredy Arias on 18/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageText.h"

@implementation MessageText

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.tag = [decoder decodeIntegerForKey:@"tag"];
        self.isHost = [decoder decodeBoolForKey:@"isHost"];
        self.text = [decoder decodeObjectForKey:@"text"];
        self.font = [decoder decodeObjectForKey:@"font"];
        self.color = [decoder decodeObjectForKey:@"color"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.tag forKey:@"tag"];
    [encoder encodeBool:self.isHost forKey:@"isHost"];
    [encoder encodeObject:self.text forKey:@"text"];
    [encoder encodeObject:self.font forKey:@"font"];
    [encoder encodeObject:self.color forKey:@"color"];
}

@end
