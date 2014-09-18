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
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    PFQuery *unansweredQuestionsQuery = [repository unansweredQuestionsQuery];
    if ([unansweredQuestionsQuery countObjects] > 0) {
        PFQuery *questionsQuery = [PFQuery queryWithClassName:@"Question"];
        PFObject *questionList = [unansweredQuestionsQuery getFirstObject];
        [questionsQuery whereKey:@"uQuestions" equalTo:questionList];
        self.selectedQuestion = [questionsQuery getFirstObject];
        
    }
    else {
        self.selectedQuestion = nil;
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
    if (self.selectedQuestion) {
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
    UnanswerQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    if (cell) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //NSLog(@"%@",[self.selectedQuestion objectForKey:@"name"]);
        [cell userNameLabel].text = [self.selectedQuestion objectForKey:@"name"];
        [cell questionTitleLabel].text = [self.selectedQuestion objectForKey:@"title"];;
        [cell questionTextTextView].text = [self.selectedQuestion objectForKey:@"text"];
        [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%@", [self.selectedQuestion objectForKey:@"upVotes"]];
        [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%@", [self.selectedQuestion objectForKey:@"downVotes"]];
        [[cell answerQuestionButton]setHidden:NO];
        [[cell answerQuestionButton] addTarget:self action:@selector(answerQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [[cell positiveButton] addTarget:self action:@selector(positiveQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [[cell negativeButton] addTarget:self action:@selector(negativeQuestion:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.selectedQuestion objectForKey:@"imageFile"]) {
            
            PFFile *thumbnail = [self.selectedQuestion objectForKey:@"imageFile"];
            PFImageView *thumbnailImageView = (PFImageView *)[cell drawImageView];
            thumbnailImageView.image = [UIImage imageNamed:@"placeholder.png"];
            thumbnailImageView.file = thumbnail;
            [thumbnailImageView loadInBackground];
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
    if ([self.selectedQuestion objectForKey:@"imageFile"])
    {
        return 365.0;
    }
    
    return 180.0;
}

- (void)changeQuestionDetail : (PFObject*) question
{
    self.selectedQuestion = question;
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
    PFImageView *imageClicked = (PFImageView *)sender.view;
    ImageDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"imageDetail"];
    [detailVC setImage:imageClicked.image];
    [self presentViewController:detailVC animated:YES completion:nil];
}

- (void) positiveQuestion: (UIButton *)sender
{
    [self.selectedQuestion incrementKey:@"upVotes" byAmount:[NSNumber numberWithInt:1]];
    [self.selectedQuestion incrementKey:@"upDownDifference" byAmount:[NSNumber numberWithInt:1]];
    [self.selectedQuestion save];
    
    [self.tableView reloadData];
    UINavigationController *VCRef = [self.splitViewController.viewControllers firstObject];
    NSArray *viewControllers = VCRef.viewControllers;
    UnansweredTableViewController *VC = [viewControllers objectAtIndex:0];
    [VC loadObjects];
    
    
}
- (void) negativeQuestion: (UIButton *)sender
{
    [self.selectedQuestion incrementKey:@"downVotes" byAmount:[NSNumber numberWithInt:1]];
    [self.selectedQuestion incrementKey:@"upDownDifference" byAmount:[NSNumber numberWithInt:-1]];
    [self.selectedQuestion save];

    [self.tableView reloadData];
    UINavigationController *VCRef = [self.splitViewController.viewControllers firstObject];
    NSArray *viewControllers = VCRef.viewControllers;
    UnansweredTableViewController *VC = [viewControllers objectAtIndex:0];
    [VC loadObjects];
}




@end