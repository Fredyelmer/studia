//
//  Photo.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 31/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        self.webformatURL = [dictionary objectForKey:@"webformatURL"];
        self.previewURL = [dictionary objectForKey:@"previewURL"];
    }
    
    return self;
}


@end
