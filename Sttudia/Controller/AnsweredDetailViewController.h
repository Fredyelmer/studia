//
//  AnsweredDetailViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsRepository.h"
#import "QuestionsTableViewCell.h"
#import "Question.h"
#import "AnsweredDetailViewController.h"
#import "NewQuestionViewController.h"
#import "ImageDetailViewController.h"
#import "AnsweredTableViewController.h"
#import "Answer.h"
#import <Parse/Parse.h>

@interface AnsweredDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* arrayQuestions;
@property (strong, nonatomic) NSArray* arrayAnswers;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Question *currentQuestion;
@property (strong, nonatomic) Answer *currentAnswer;
@property (strong, nonatomic) PFObject *selectedQuestion;
@property (strong, nonatomic) PFObject *answeredQuestionList;
@property (strong, nonatomic) NSMutableArray *userArray;

- (void)changeQuestionDetail : (PFObject*) selectedQuestion;
@end
