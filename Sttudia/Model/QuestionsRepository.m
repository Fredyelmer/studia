//
//  QuestionsRepository.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 28/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "QuestionsRepository.h"

@implementation QuestionsRepository

static QuestionsRepository *questionsRepository= nil;

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [QuestionsRepository sharedRepository];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.answeredQuestionsArray = [[NSMutableArray alloc]init];
        self.unansweredQuestionsArray = [[NSMutableArray alloc]init];
        UIImage *image = [UIImage imageNamed:@"placeholder.png"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20.0, 186.0, 362.0, 204.0)];
        imageView.image = image;
        Question *question = [[Question alloc]initWithTitle:@"titulo" subject:@"Ola sou o david" text:@"batatinha Quando Nasce Se esparrama pelo chão menininha quando dorme poes amão no coração" image: imageView.image];
        Question *question2 = [[Question alloc]initWithTitle:@"titulo2" subject:@"Ola mundo" text:@"batatinha feliz" image: imageView.image];
        [question setUpVotes:17];
        [question2 setUpVotes:10];
        Question *question3 = [[Question alloc]initWithTitle:@"titulo" subject:@"Ola sou o david" text:@"menininha quando dorme poe mamao" image: imageView.image];
        [question3 setUpVotes:13];
        
        Question *question4 = [[Question alloc]initWithTitle:@"titulo2" subject:@"Ola sou o david" text:@"menininha quando dorme poe mamao" image: imageView.image];
        [question4 setUpVotes:1];
        Question *question5 = [[Question alloc]initWithTitle:@"titulo3" subject:@"Ola sou o david" text:@"menininha quando dorme poe mamao" image: imageView.image];
        
        [question5 setUpVotes:3];

        Answer *answer = [[Answer alloc]initWithTitle: [question title] subject:[question subject] text:[question text] image:imageView.image];
        
        
        [[question answersArray] addObject:answer];
        
        [question setVotesDifference];
        [question2 setVotesDifference];
        [question3 setVotesDifference];
        [question4 setVotesDifference];
        [question5 setVotesDifference];
        
        [self.answeredQuestionsArray addObject:question];

        [self.unansweredQuestionsArray addObject:question2];
        [self.unansweredQuestionsArray addObject:question3];
        [self.unansweredQuestionsArray addObject:question4];
        [self.unansweredQuestionsArray addObject:question5];
        
    }
    return self;
}

+(QuestionsRepository *)sharedRepository
{
    if (!questionsRepository) {
        questionsRepository= [[super allocWithZone:nil] init];
    }
    
    return questionsRepository;
}

- (void) addAnsweredQuestion : (Question *)question
{
    [self.answeredQuestionsArray addObject:question];
}

- (void) addUnansweredQuestion : (Question *)question
{
    [self.unansweredQuestionsArray addObject:question];
}

- (void) changeQuestionCategory:(Question *)question
{
    [self.unansweredQuestionsArray removeObject:question];
    
    [self.answeredQuestionsArray addObject:question];

}

@end
