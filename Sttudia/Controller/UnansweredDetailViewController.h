//
//  UnanwsredDetailViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsRepository.h"
#import "QuestionsTableViewCell.h"
#import "Question.h"
#import "UnansweredTableViewController.h"


@interface UnansweredDetailViewController : UIViewController

@property (strong, nonatomic) NSMutableArray* arrayQuestions;
@property (strong, nonatomic) NSMutableArray* arrayAnswers;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Question *currentQuestion;

- (void)changeQuestionDetail : (Question*) question;
@end
