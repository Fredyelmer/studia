//
//  PhotoRepository.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 31/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "PhotoRepository.h"

@implementation PhotoRepository

static PhotoRepository *photoRepository= nil;

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [PhotoRepository sharedRepository];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.arrayPhotos = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - Singleton methods

+(PhotoRepository *)sharedRepository
{
    if (!photoRepository) {
        photoRepository= [[super allocWithZone:nil] init];
    }
    
    return photoRepository;
}

#pragma mark - Public methods

-(NSArray *)lista
{
    return [self.arrayPhotos copy];
}

-(void)addPhoto:(Photo *)photo
{
    [self.arrayPhotos addObject:photo];
}

-(void)removeRecipeAtIndex:(NSInteger)index
{
    if (index >= 0 && index < [self.arrayPhotos count]) {
        [self.arrayPhotos removeObjectAtIndex:index];
    }
}

-(void)removeAllPhotos
{
    [self.arrayPhotos removeAllObjects];
    
}


@end
