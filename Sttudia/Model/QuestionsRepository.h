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

@interface QuestionsRepository : NSObject

@property (strong ,nonatomic) NSMutableArray *answeredQuestionsArray;

@property (strong ,nonatomic) NSMutableArray *unansweredQuestionsArray;

@property (strong, nonatomic) NSString *objectID;

@property (strong, nonatomic) PFObject *qRepository;
@property (strong, nonatomic) PFQuery *answeredQuestionsQuery;
@property (strong, nonatomic) PFQuery *unansweredQuestionsQuery;

+(id)allocWithZone:(struct _NSZone *)zone;

+(QuestionsRepository *)sharedRepository;

- (void) addAnsweredQuestion : (Question *)question;
- (void) addUnansweredQuestion : (Question *)question;
- (void) changeQuestionCategory : (Question *)question;

@end
