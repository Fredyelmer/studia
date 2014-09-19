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

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

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
        PFQuery *uQuestionsQuery = [PFQuery queryWithClassName:@"UnansweredQuestions"];
        PFObject *currentRepository = [questionRepository qRepository];
        [uQuestionsQuery whereKey:@"repository" equalTo: currentRepository];
        self.currentUQuestionsList = [uQuestionsQuery getFirstObject];
        [questionRepository setUnansweredQuestionsQuery:uQuestionsQuery];

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
//    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
//    self.arrayUnansweredQuestion = [repository unansweredQuestionsArray];
    //[self sortUnansweredQuestionsArray];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    //self.detail = [self.splitViewController.viewControllers lastObject];
    //[self.detail changeQuestionDetail:[self.arrayUnansweredQuestion objectAtIndex:indexPath.row]];
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
    
    [cell questionTitleLabel].text = [object objectForKey:@"title"];
    [cell userNameLabel].text = [object objectForKey:@"text"];
    [cell numPositiveLabel].text = [NSString stringWithFormat:@"%@",[object objectForKey:@"upVotes"]];
    [cell numNegativeLabel].text = [NSString stringWithFormat:@"%@",[object objectForKey:@"downVotes"]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Question *question = [self.arrayUnansweredQuestion objectAtIndex:indexPath.row];
    
    PFObject *questionSelected = [self.objects objectAtIndex:indexPath.row];
    self.detail = [self.splitViewController.viewControllers lastObject];

    [self.detail changeQuestionDetail:questionSelected];
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

- (PFQuery *)queryForTable
{
    
//    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
//    self.arrayUnansweredQuestion = [repository unansweredQuestionsArray];
    
    PFQuery *questionsQuery = [PFQuery queryWithClassName:self.parseClassName];
    [questionsQuery whereKey:@"uQuestions" equalTo:self.currentUQuestionsList];
    
    [questionsQuery orderByDescending:@"upDownDifference"];
    return questionsQuery;
}
@end
