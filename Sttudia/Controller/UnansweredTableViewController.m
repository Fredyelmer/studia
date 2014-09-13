//
//  UnansweredTableViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "UnansweredTableViewController.h"

@interface UnansweredTableViewController ()

@property (strong, nonatomic) UnansweredDetailViewController * detail;

@end

@implementation UnansweredTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.arrayUnansweredQuestion = [[NSMutableArray alloc]init];
    
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    self.arrayUnansweredQuestion = [repository unansweredQuestionsArray];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    //[repository sortUnansweredQuestionsArray];
    self.arrayUnansweredQuestion = [repository unansweredQuestionsArray];
    [self sortUnansweredQuestionsArray];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    self.detail = [self.splitViewController.viewControllers lastObject];
    [self.detail changeQuestionDetail:[self.arrayUnansweredQuestion objectAtIndex:indexPath.row]];

    //[self sortUnansweredQuestionsArray];
    //[self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayUnansweredQuestion count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UnanswerQuestionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Question *question = [self.arrayUnansweredQuestion objectAtIndex:indexPath.row];
    
    [cell questionTitleLabel].text = [question title];
    [cell questionSubjectLabel].text = [question subject];
    [cell numPositiveLabel].text = [NSString stringWithFormat:@"%d",[question upVotes]];
    [cell numNegativeLabel].text = [NSString stringWithFormat:@"%d",[question downVotes]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Question *question = [self.arrayUnansweredQuestion objectAtIndex:indexPath.row];
    
    self.detail = [self.splitViewController.viewControllers lastObject];
    [self.detail changeQuestionDetail:question];
    //[self.delegate changeQuestionDetail : question];
}
- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) sortUnansweredQuestionsArray
{
    NSSortDescriptor *sDescriptor = [[NSSortDescriptor alloc]initWithKey:@"upDownDifference" ascending:NO];
    self.arrayUnansweredQuestion = (NSMutableArray *)[self.arrayUnansweredQuestion sortedArrayUsingDescriptors:@[sDescriptor]];
}

@end
