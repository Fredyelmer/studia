//
//  UnansweredDetailViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "UnansweredDetailViewController.h"

@interface UnansweredDetailViewController ()

@end

@implementation UnansweredDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
//    if ([[repository unansweredQuestionsArray]count] > 0) {
//        self.currentQuestion = [[repository unansweredQuestionsArray]objectAtIndex:0];
//        self.arrayAnswers = [self.currentQuestion answersArray];
//    }
//    else {
//        self.currentQuestion = nil;
//    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    if ([[repository unansweredQuestionsArray]count] > 0) {
        //self.currentQuestion = [[repository unansweredQuestionsArray]objectAtIndex:0];
        self.arrayAnswers = [self.currentQuestion answersArray];
    }
    else {
        self.currentQuestion = nil;
    }

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.currentQuestion) {
        return 1;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = @"Pergunta";
    
    return sectionName;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    if (cell) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell questionTitleLabel].text = [self.currentQuestion title];
        [cell questionSubjectTextView].text = [self.currentQuestion subject];
        [cell questionTextTextView].text = [self.currentQuestion text];
        [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%d", [self.currentQuestion upVotes]];
        [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%d", [self.currentQuestion downVotes]];
        [[cell answerQuestionButton]setHidden:NO];
        [[cell answerQuestionButton] addTarget:self action:@selector(answerQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [[cell positiveButton] addTarget:self action:@selector(positiveQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [[cell negativeButton] addTarget:self action:@selector(negativeQuestion:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.currentQuestion drawImage]) {
            [cell drawImageView].image = [self.currentQuestion drawImage];
            [[cell drawImageView]setHidden:NO];
            [[cell drawImageView] setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
            [[cell drawImageView]addGestureRecognizer:tapGesture];
        }
        else {
            [[cell drawImageView]setHidden:YES];
        }
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.currentQuestion drawImage])
    {
        return 408.0;
    }
    
    return 220.0;
}

- (void)changeQuestionDetail : (Question*) question
{
    self.currentQuestion = question;
    //[self.currentQuestion sortAnswers];
    self.arrayAnswers = [question answersArray];
    [self.tableView reloadData];
    
}

- (void)answerQuestion: (UIButton *)sender
{
    NewQuestionViewController *newQuestionVCRef = (NewQuestionViewController *)[[self.tabBarController viewControllers] objectAtIndex:2];
    [newQuestionVCRef setCurrentQuestion:self.currentQuestion];
    [newQuestionVCRef setIsAnswer:YES];
    [self.tabBarController setSelectedIndex:2];

}

- (void) zoomImage: (UITapGestureRecognizer *)sender
{
    UIImageView *imageClicked = (UIImageView *)sender.view;
    ImageDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"imageDetail"];
    [detailVC setImage:imageClicked.image];
    [self presentViewController:detailVC animated:YES completion:nil];
}

- (void) positiveQuestion: (UIButton *)sender
{
    [self.currentQuestion setUpVotes:[self.currentQuestion upVotes]+1];
    [self.currentQuestion setVotesDifference];
    [self.tableView reloadData];
    UINavigationController *VCRef = [self.splitViewController.viewControllers firstObject];
    NSArray *viewControllers = VCRef.viewControllers;
    UnansweredTableViewController *VC = [viewControllers objectAtIndex:0];
    [[VC tableView] reloadData];
    
    
}
- (void) negativeQuestion: (UIButton *)sender
{
    [self.currentQuestion setDownVotes:[self.currentQuestion downVotes]+1];
    [self.currentQuestion setVotesDifference];
    [self.tableView reloadData];
    UINavigationController *VCRef = [self.splitViewController.viewControllers firstObject];
    NSArray *viewControllers = VCRef.viewControllers;
    UnansweredTableViewController *VC = [viewControllers objectAtIndex:0];
    [[VC tableView] reloadData];
}




@end
