//
//  VideoPlayer.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 24/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "VideoPlayer.h"

@implementation VideoPlayer

- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (BOOL) playVideo : (NSMutableArray*)arrayParametros
{
    for (int i = 0; i < [arrayParametros count]; i++) {
        
        if ([arrayParametros[i] isDrawing]){
            //[self performSelector:@selector(draw:) withObject:arrayParametros[i] afterDelay:[arrayParametros[i] interval]];
        }
    }

    return YES;
}

- (void) pauseVideo
{

}

- (void) stopVideo
{

}

@end
