//
//  Photo.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 31/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSString *webformatURL;
@property (strong, nonatomic) NSString *previewURL;


-(id) initWithDictionary:(NSDictionary *)dictionary;

@end
