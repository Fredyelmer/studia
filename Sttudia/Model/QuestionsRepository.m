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
        
        Question *question = [[Question alloc]initWithTitle:@"titulo" subject:@"Ola sou o david" text:@"batatinha Quando Nasce Se esparrama pelo chão menininha quando dorme poes amão no coração" image: nil];
        
        Answer *answer = [[Answer alloc]initWithTitle: [question title] subject:[question subject] text:[question text] image:nil];
        
        for (int i = 0; i < 3; i++) {
            [[question answersArray] addObject:answer];
        }
        
        for (int i = 0; i < 10; i++) {
            [self.answeredQuestionsArray addObject:question];
        }
        
        question = [[Question alloc]initWithTitle:@"titulo3" subject:@"Ola sou o davids" text:@"batatinha Quando Nasce Se esparrama pelo chão menininha quando dorme poes amão no coração" image: nil];
        
        Answer *answer2 = [[Answer alloc]initWithTitle: @"teste" subject:@"testeSubject" text:@"Esse é o teste de troca de contexto" image:nil];
        [[question answersArray] addObject:answer2];
        
        [self.answeredQuestionsArray addObject:question];
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

- (void) sortByVotes : (NSMutableArray *)array : (Question *)question
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"upVotes"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [self.answeredQuestionsArray sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSMutableArray *)getAnsweredQuestionsArray
{
    return self.answeredQuestionsArray;
}

- (NSMutableArray *)getUnansweredQuestionsArray
{
    return self.unansweredQuestionsArray;
}
@end
