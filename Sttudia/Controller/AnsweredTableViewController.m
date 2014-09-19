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
        PFQuery *aQuestionsQuery = [PFQuery queryWithClassName:@"AnsweredQuestions"];
        PFObject *currentRepository = [questionRepository qRepository];
        [aQuestionsQuery whereKey:@"repository" equalTo: currentRepository];
        self.currentAQuestionsList = [aQuestionsQuery getFirstObject];
        [questionRepository setAnsweredQuestionsQuery:aQuestionsQuery];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayAnsweredQuestion = [[NSMutableArray alloc]init];
    
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    //[repository sortAnsweredQuestionsArray];
    self.arrayAnsweredQuestion = [repository answeredQuestionsArray];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    //[repository sortAnsweredQuestionsArray];
    self.arrayAnsweredQuestion = [repository answeredQuestionsArray];
    //[self.tableView reloadData];
    
    [self loadObjects];

    
//    [self sortAnsweredQuestionsArray];
//    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    self.detail = [self.splitViewController.viewControllers lastObject];
//    [self.detail changeQuestionDetail:[self.arrayAnsweredQuestion objectAtIndex:indexPath.row]];
    [self.tableView reloadData];
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

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.arrayAnsweredQuestion count];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    QuestionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //Question *question = [self.arrayAnsweredQuestion objectAtIndex:indexPath.row];
    
    [cell questionTitleLabel].text = [object objectForKey:@"title"];
    [cell userNameLabel].text = [object objectForKey:@"text"];
    [cell numPositiveLabel].text = [NSString stringWithFormat:@"%@",[object objectForKey:@"upVotes"]];
    [cell numNegativeLabel].text = [NSString stringWithFormat:@"%@",[object objectForKey:@"downVotes"]];
    
//    [cell questionTitleLabel].text = [question title];
//    [cell userNameLabel].text = [question author];
//    [cell numPositiveLabel].text = [NSString stringWithFormat:@"%d",[question upVotes]];
//    [cell numNegativeLabel].text = [NSString stringWithFormat:@"%d",[question downVotes]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Question *question = [self.arrayAnsweredQuestion objectAtIndex:indexPath.row];
//    
//    self.detail = [self.splitViewController.viewControllers lastObject];
//    [self.detail changeQuestionDetail:question];
    //[self.delegate changeQuestionDetail : question];
    
    PFObject *questionSelected = [self.objects objectAtIndex:indexPath.row];
    self.detail = [self.splitViewController.viewControllers lastObject];
    
    [self.detail changeQuestionDetail:questionSelected];

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
    //QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    //self.arrayUnansweredQuestion = [repository unansweredQuestionsArray];
    
    PFQuery *questionsQuery = [PFQuery queryWithClassName:self.parseClassName];
    [questionsQuery whereKey:@"aQuestions" equalTo:self.currentAQuestionsList];
    
    [questionsQuery orderByDescending:@"upDownDifference"];
    return questionsQuery;
}


@end
