//
//  PhotoRequest.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 30/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoRequest;

@protocol PhotoRequestDelegate <NSObject>

@optional

-(void) request: (PhotoRequest*) request didFinishWithObject:(id) object;

-(void) request: (PhotoRequest*) request didFailWithError:(NSError*) error;

@end

@interface PhotoRequest : NSObject <NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSString* key;
- (id)initWithKey : (NSString*) key;
- (void) requestForRecipes:(id<PhotoRequestDelegate>) delegate;
- (NSURL*) urlForKey: (NSString*)key;

@end
