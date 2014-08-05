//
//  PhotoRepository.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 31/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface PhotoRepository : NSObject

@property (nonatomic, strong) NSMutableArray *arrayPhotos;

+(PhotoRepository *)sharedRepository;

-(NSArray *)lista;

-(void)addPhoto: (Photo *)photo;

-(void)removeAllPhotos;

@end
