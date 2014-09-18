//
//  MessagePoint.m
//  Sttudia
//
//  Created by Fredy Arias on 16/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "MessagePoint.h"

@implementation MessagePoint

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.point = [decoder decodeObjectForKey:@"point"];
        self.actionName = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.point forKey:@"point"];
    [encoder encodeObject:self.actionName forKey:@"name"];
}
@end
