//
//  QuestionsRepository.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 28/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface QuestionsRepository : NSObject

@property (strong ,nonatomic) NSMutableArray *answeredQuestionsArray;

@property (strong ,nonatomic) NSMutableArray *unansweredQuestionsArray;

+(id)allocWithZone:(struct _NSZone *)zone;

+(QuestionsRepository *)sharedRepository;

- (void) addAnsweredQuestion : (Question *)question;

- (void) addUnansweredQuestion : (Question *)question;

- (void) changeQuestionCategory : (Question *)question;

- (NSMutableArray *) getAnsweredQuestionsArray;

- (NSMutableArray *) getUnansweredQuestionsArray;

@end
