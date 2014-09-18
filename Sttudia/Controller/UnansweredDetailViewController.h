//
//  UnanwsredDetailViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsRepository.h"
#import "UnanswerQuestionTableViewCell.h"
#import "Question.h"
#import "UnansweredTableViewController.h"
#import "NewQuestionViewController.h"
#import "ImageDetailViewController.h"
#import <Parse/Parse.h>

@interface UnansweredDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* arrayQuestions;
@property (strong, nonatomic) NSMutableArray* arrayAnswers;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Question *currentQuestion;
@property (strong, nonatomic) PFObject *selectedQuestion;
@property (strong, nonatomic) PFObject *unansweredQuestionList;

- (void)changeQuestionDetail : (PFObject*) question;

@end
