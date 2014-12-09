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

- (void)changeRepository : (PFObject *)classObject{
    
    if (self) {
        
        
        //requisição do repositório ja criado. No caso devemos criar um novo ou usar um existente dependendo da utilização
        PFQuery *repositoryQuery = [PFQuery queryWithClassName:@"QuestionsRepository"];
        
        [repositoryQuery whereKey:@"class" equalTo:classObject];
        
        //self.qRepository = [repositoryQuery getObjectWithId:self.objectID];
        
//        [repositoryQuery getFirstObjectInBackgroundWithBlock:^(PFObject* object, NSError *error){
//            self.qRepository = object;
//            PFQuery *uQuestionsQuery = [PFQuery queryWithClassName:@"UnansweredQuestions"];
//            [uQuestionsQuery whereKey:@"repository" equalTo: object];
//            self.unansweredQuestionsQuery = uQuestionsQuery;
//            self.unansweredQuestionsList = [uQuestionsQuery getFirstObject];
//            
//            PFQuery *aQuestionsQuery = [PFQuery queryWithClassName:@"AnsweredQuestions"];
//            [aQuestionsQuery whereKey:@"repository" equalTo: object];
//            self.answeredQuestionsQuery = aQuestionsQuery;
//            self.answeredQuestionsList = [aQuestionsQuery getFirstObject];
//            
//            [self.delegate didFinishedLoadRepository];
//        
//        }];
        
        [repositoryQuery getFirstObjectInBackgroundWithBlock:^(PFObject* object, NSError *error){
            if (!error) {
                self.qRepository = object;
                PFQuery *uQuestionsQuery = [PFQuery queryWithClassName:@"UnansweredQuestions"];
                [uQuestionsQuery whereKey:@"repository" equalTo: object];
                self.unansweredQuestionsQuery = uQuestionsQuery;
                [uQuestionsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *uQuestionList, NSError *error2){
                    if (!error2) {
                        self.unansweredQuestionsList = uQuestionList;
                        [self.delegate didFinishedLoadRepository];
                    }
                    
                }];

                
                PFQuery *aQuestionsQuery = [PFQuery queryWithClassName:@"AnsweredQuestions"];
                [aQuestionsQuery whereKey:@"repository" equalTo: object];
                self.answeredQuestionsQuery = aQuestionsQuery;
                [aQuestionsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *aQuestionList, NSError *error3){
                    if (!error3) {
                        self.answeredQuestionsList = aQuestionList;
                        [self.delegate didFinishedLoadAQuestion];
                    }
                    
                }];
                
                [self.delegate didFinishedLoadRepository];
            }
            
        }];
    }

}

- (id)init
{
    self = [super init];
    
    if (self) {
//      PFUser *user = [PFUser currentUser];
//        if (user) {
//            PFQuery *classRepositoryQuery = [PFQuery queryWithClassName:@"ClassRepository"];
//            [classRepositoryQuery whereKey:@"user" equalTo:user];
//            
//            [classRepositoryQuery getFirstObjectInBackgroundWithBlock:^(PFObject* object, NSError *error){
//                if (!error) {
//                    self.classRepository = object;
//                    PFQuery *classQuery = [PFQuery queryWithClassName:@"Class"];
//                    [classQuery whereKey:@"classRepository" equalTo:object];
//                    self.classObject = [classQuery getFirstObject];
//                }
//            }];
//        }
//        
        
        
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
                //self.unansweredQuestionsList = [uQuestionsQuery getFirstObject];
                [uQuestionsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *uQuestionList, NSError *error2){
                    if (!error2) {
                        self.unansweredQuestionsList = uQuestionList;
                        [self.delegate didFinishedLoadRepository];
                    }
                
                }];
                
                PFQuery *aQuestionsQuery = [PFQuery queryWithClassName:@"AnsweredQuestions"];
                [aQuestionsQuery whereKey:@"repository" equalTo: object];
                self.answeredQuestionsQuery = aQuestionsQuery;
                //self.answeredQuestionsList = [aQuestionsQuery getFirstObject];
                [aQuestionsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *aQuestionList, NSError *error3){
                    if (!error3) {
                        self.answeredQuestionsList = aQuestionList;
                        [self.delegate didFinishedLoadAQuestion];
                    }
                    
                }];
                
                //[self.delegate didFinishedLoadRepository];
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
