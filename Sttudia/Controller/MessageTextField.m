//
//  MessageTextField.m
//  Sttudia
//
//  Created by Fredy Arias on 18/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessageTextField.h"

@implementation MessageTextField

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.textField = [decoder decodeObjectForKey:@"text"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.textField forKey:@"text"];
}

@end
