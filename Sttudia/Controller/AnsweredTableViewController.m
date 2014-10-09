//
//  AnsweredTableViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "AnsweredTableViewController.h"

@interface AnsweredTableViewController ()

@property (strong, nonatomic) AnsweredDetailViewController * detail;

@end

@implementation AnsweredTableViewController


- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Question";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        //self.objectsPerPage = 10;
        
        QuestionsRepository *questionRepository = [QuestionsRepository sharedRepository];
        self.currentAQuestionsList = [questionRepository answeredQuestionsList];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayAnsweredQuestion = [[NSMutableArray alloc]init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadObjects];

//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
//    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    [self.tableView reloadData];
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    QuestionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!self.selectedQuestion && indexPath.row == 0) {
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        self.detail = [self.splitViewController.viewControllers lastObject];
        [self.detail changeQuestionDetail:self.selectedQuestion];
        
    }
    
    if ([[object objectForKey:@"title"]isEqual:[self.selectedQuestion objectForKey:@"title"]]) {
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        self.detail = [self.splitViewController.viewControllers lastObject];
        [self.detail changeQuestionDetail:self.selectedQuestion];
    }
    
    [cell questionTitleLabel].text = [object objectForKey:@"title"];
    [cell userNameLabel].text = [object objectForKey:@"text"];
    [cell numPositiveLabel].text = [NSString stringWithFormat:@"%@",[object objectForKey:@"upVotes"]];
    [cell numNegativeLabel].text = [NSString stringWithFormat:@"%@",[object objectForKey:@"downVotes"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedQuestion = [self.objects objectAtIndex:indexPath.row];
    self.detail = [self.splitViewController.viewControllers lastObject];
    
    [self.detail changeQuestionDetail:self.selectedQuestion];

}
- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) sortAnsweredQuestionsArray
{
    NSSortDescriptor *sDescriptor = [[NSSortDescriptor alloc]initWithKey:@"upDownDifference" ascending:NO];
    self.arrayAnsweredQuestion = (NSMutableArray *)[self.arrayAnsweredQuestion sortedArrayUsingDescriptors:@[sDescriptor]];
}
- (PFQuery *)queryForTable
{
    PFQuery *questionsQuery = [PFQuery queryWithClassName:self.parseClassName];
    [questionsQuery whereKey:@"aQuestions" equalTo:self.currentAQuestionsList];
    
    [questionsQuery orderByDescending:@"upDownDifference"];
    return questionsQuery;
}


@end
