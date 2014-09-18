//
//  Answer.m
//  Sttudia
//
//  Created by Helder Lima da Rocha on 7/3/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "Answer.h"

@implementation Answer

// Inicia uma pergunta com texto proposto contadores de rank zerados
- (id)initWithAuthor:(NSString *)author text: (NSString*)text image: (UIImage *)image
{
    self = [super init];
    if(self){
        
        self.author = author;
        self.text = text;
        self.upVotes = 0;
        self.downVotes = 0;
        self.spamCounter = 0;
        self.drawImage = image;
    }
    
    return self;
}

- (void) setVotesDifference
{
    self.upDownDifference = self.upVotes - self.downVotes;
    
}

@end
