//
//  Question.m
//  Sttudia
//
//  Created by Helder Lima da Rocha on 7/3/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "Question.h"

@implementation Question

- (id)initWithTitle:(NSString *)title subject: (NSString*)subject text: (NSString*)text image: (UIImage*)image
{
    self = [super init];
    if(self){
        self.title = title;
        self.subject = subject;
        self.text = text;
        self.answersArray = [[NSMutableArray alloc] init];
        self.upVotes = 0;
        self.downVotes = 0;
        self.spamCounter = 0;
        self.drawImage = image;
    }
    
    return self;
}

- (void)sortAnswersBy:(NSInteger)type{
    // A implementar
}

@end
