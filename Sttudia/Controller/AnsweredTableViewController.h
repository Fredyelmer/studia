//
//  AnsweredTableViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsRepository.h"
#import "Question.h"
#import "QuestionListTableViewCell.h"
#import "AnsweredDetailViewController.h"

@interface AnsweredTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *arrayAnsweredQuestion;


@end
