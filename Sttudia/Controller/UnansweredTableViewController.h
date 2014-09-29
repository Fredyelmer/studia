//
//  UnansweredTableViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsRepository.h"
#import "Question.h"
#import "UnanswerQuestionListTableViewCell.h"
#import "UnansweredDetailViewController.h"
#import <Parse/Parse.h>

@interface UnansweredTableViewController : PFQueryTableViewController//UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *arrayUnansweredQuestion;

@property (strong, nonatomic) PFQuery *currentUQuestions;

@property (strong, nonatomic) PFObject *currentUQuestionsList;

@property (strong, nonatomic) PFObject *selectedQuestion;
@end
