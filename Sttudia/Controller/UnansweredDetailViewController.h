//
//  UnanwsredDetailViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnansweredDetailViewController : UIViewController

@property (strong, nonatomic) NSMutableArray* arrayQuestions;
@property (strong, nonatomic) NSMutableArray* arrayAnwsers;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
