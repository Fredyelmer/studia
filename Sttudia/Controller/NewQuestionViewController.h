//
//  NewQuestionViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 28/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "QuestionsRepository.h"
#import "Question.h"
#import "Answer.h"


@interface NewQuestionViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

//@property (strong, nonatomic) Question *currentQuestion;
@property (strong, nonatomic) Answer *currentAnswer;
@property (assign, nonatomic) BOOL isAnswer;
@property (strong, nonatomic) PFObject *currentQuestion;
@property (strong, nonatomic) IBOutlet UISwitch *isAnonymSwitch;
@property (strong, nonatomic) IBOutlet UIView *toolBarView;

@end
