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
        
        //requisição do repositório ja criado. No caso devemos criar um novo ou usar um existente dependendo da utilização
        PFQuery *repositoryQuery = [PFQuery queryWithClassName:@"QuestionsRepository"];
        //[repositoryQuery whereKey:@"objectId" equalTo:@"cfOU0YHATN"];
        self.objectID = @"cfOU0YHATN";
        
        //self.qRepository = [repositoryQuery getObjectWithId:self.objectID];
        
        [repositoryQuery getObjectInBackgroundWithId:self.objectID block:^(PFObject* object, NSError *error){
            if (!error) {
                self.qRepository = object;
                PFQuery *uQuestionsQuery = [PFQuery queryWithClassName:@"UnansweredQuestions"];
                [uQuestionsQuery whereKey:@"repository" equalTo: object];
                self.unansweredQuestionsQuery = uQuestionsQuery;
                self.unansweredQuestionsList = [uQuestionsQuery getFirstObject];
//                [uQuestionsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *uQuestionList, NSError *error2){
//                    if (!error2) {
//                        self.unansweredQuestionsList = uQuestionList;
//                    }
//                
//                }];
                
                PFQuery *aQuestionsQuery = [PFQuery queryWithClassName:@"AnsweredQuestions"];
                [aQuestionsQuery whereKey:@"repository" equalTo: object];
                self.answeredQuestionsQuery = aQuestionsQuery;
                self.answeredQuestionsList = [aQuestionsQuery getFirstObject];
//                [uQuestionsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *aQuestionList, NSError *error3){
//                    if (!error3) {
//                        self.answeredQuestionsList = aQuestionList;
//                    }
//                    
//                }];
                
                [self.delegate didFinishedLoadRepository];
            }
            //self.repositoryReady = YES;
            
        }];
        
        
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

@end
