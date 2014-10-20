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
        self.currentUQuestionsList = [questionRepository unansweredQuestionsList];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.arrayUnansweredQuestion = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.currentUser = [PFUser currentUser];
    [self loadObjects];
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
    UnanswerQuestionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (([[self.currentUser objectForKey:@"category"]isEqualToString:@"Student"] && [object objectForKey:@"isPublic"])||([[self.currentUser objectForKey:@"category"]isEqualToString:@"Teacher"])) {
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
    }
//    
//    
//    if (!self.selectedQuestion && indexPath.row == 0) {
//        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
//        self.detail = [self.splitViewController.viewControllers lastObject];
//        [self.detail changeQuestionDetail:self.selectedQuestion];
//
//    }
//    
//    
//    if ([[object objectForKey:@"title"]isEqual:[self.selectedQuestion objectForKey:@"title"]]) {
//        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
//        self.detail = [self.splitViewController.viewControllers lastObject];
//        [self.detail changeQuestionDetail:self.selectedQuestion];
//    }
//    
//    [cell questionTitleLabel].text = [object objectForKey:@"title"];
//    [cell userNameLabel].text = [object objectForKey:@"text"];
//    [cell numPositiveLabel].text = [NSString stringWithFormat:@"%@",[object objectForKey:@"upVotes"]];
//    [cell numNegativeLabel].text = [NSString stringWithFormat:@"%@",[object objectForKey:@"downVotes"]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedQuestion = [self.objects objectAtIndex:indexPath.row];
    self.detail = [self.splitViewController.viewControllers lastObject];

    [self.detail changeQuestionDetail: self.selectedQuestion];
}
- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) sortUnansweredQuestionsArray
{
    NSSortDescriptor *sDescriptor = [[NSSortDescriptor alloc]initWithKey:@"upDownDifference" ascending:NO];
    self.arrayUnansweredQuestion = (NSMutableArray *)[self.arrayUnansweredQuestion sortedArrayUsingDescriptors:@[sDescriptor]];
}

- (PFQuery *)queryForTable
{
    PFQuery *questionsQuery = [PFQuery queryWithClassName:self.parseClassName];
    [questionsQuery whereKey:@"uQuestions" equalTo:self.currentUQuestionsList];
    
    [questionsQuery orderByDescending:@"upDownDifference"];
    return questionsQuery;
}
@end
