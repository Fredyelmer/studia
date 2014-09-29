//
//  QuestionsRepository.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 28/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Question.h"
@class QuestionsRepository;
@protocol QuestionRepositoryDelegate <NSObject>

- (void) didFinishedLoadRepository;

@end
@interface QuestionsRepository : NSObject

@property (nonatomic, weak) id <QuestionRepositoryDelegate> delegate;

@property (strong, nonatomic) NSString *objectID;
@property (assign, nonatomic) BOOL repositoryReady;
@property (strong, nonatomic) PFObject *qRepository;
@property (strong, nonatomic) PFObject *unansweredQuestionsList;
@property (strong, nonatomic) PFObject *answeredQuestionsList;
@property (strong, nonatomic) PFQuery *answeredQuestionsQuery;
@property (strong, nonatomic) PFQuery *unansweredQuestionsQuery;

+(id)allocWithZone:(struct _NSZone *)zone;

+(QuestionsRepository *)sharedRepository;

@end
