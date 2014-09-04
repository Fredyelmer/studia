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
- (id)initWithTitle:(NSString *)title subject: (NSString*)subject text: (NSString*)text image: (UIImageView *)image
{
    self = [super init];
    if(self){
        
        self.title = title;
        self.subject = subject;
        self.text = text;
        self.upVotes = 0;
        self.downVotes = 0;
        self.spamCounter = 0;
        self.drawImageView = image;
    }
    
    return self;
}

@end
