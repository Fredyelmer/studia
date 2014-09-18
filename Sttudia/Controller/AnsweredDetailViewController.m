//
//  AnsweredDetailViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 01/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "AnsweredDetailViewController.h"

@interface AnsweredDetailViewController ()

@end

@implementation AnsweredDetailViewController

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
    //QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    //self.currentQuestion = [[repository answeredQuestionsArray]objectAtIndex:0];
    //self.arrayAnswers = [self.currentQuestion answersArray];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    
    PFQuery *answeredQuestionsQuery = [repository answeredQuestionsQuery];
    if ([answeredQuestionsQuery countObjects] > 0) {
        PFQuery *questionsQuery = [PFQuery queryWithClassName:@"Question"];
        PFObject *questionList = [answeredQuestionsQuery getFirstObject];
        [questionsQuery whereKey:@"aQuestions" equalTo:questionList];
        self.selectedQuestion = [questionsQuery getFirstObject];
        
        PFQuery *answersQuery = [PFQuery queryWithClassName:@"Answer"];
        [answersQuery whereKey:@"question" equalTo:self.selectedQuestion];
//        [answersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (!error) {
//                self.arrayAnswers = objects;
//            }
//            else {
//                NSLog(@"Error: %@ %@", error, [error userInfo]);
//            }
//        }];
        
        self.arrayAnswers = [answersQuery findObjects];
    }
    else {
        self.selectedQuestion = nil;
    }

    //self.currentQuestion = [[repository answeredQuestionsArray]objectAtIndex:0];
//    self.arrayAnswers = [self.currentQuestion answersArray];
//    [self sortAnswers];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else {
        return [self.arrayAnswers count];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    if (section == 0) {
        sectionName = @"Pergunta";
    }
    else {
        sectionName = @"Respostas";
    }
    return sectionName;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    if (cell) {
        if (indexPath.section == 0) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
        else if (indexPath.section == 1) {
            PFObject *answer = [self.arrayAnswers objectAtIndex:indexPath.row];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [cell userNameLabel].text = [answer objectForKey:@"name"];
            [cell questionTitleLabel].text = nil;
            [cell questionTextTextView].text = [answer objectForKey:@"text"];
            [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%@", [answer objectForKey:@"upVotes"]];
            [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%@", [answer objectForKey:@"downVotes"]];
            
//            [cell questionTitleLabel].text = nil;
//            [cell userNameLabel].text = [answer author];
//            [cell questionTextTextView].text = [answer text];
//            [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%d", [answer upVotes]];
//            [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%d", [answer downVotes]];
            [cell positiveButton].tag = indexPath.row;
            [[cell positiveButton] addTarget:self action:@selector(positiveAnswer:) forControlEvents:UIControlEventTouchUpInside];
            [cell negativeButton].tag = indexPath.row;
            [[cell negativeButton] addTarget:self action:@selector(negativeAnswer:) forControlEvents:UIControlEventTouchUpInside];
            [[cell answerQuestionButton]setHidden:YES];
            if ([answer objectForKey:@"ImageFile"]) {
                PFFile *thumbnail = [answer objectForKey:@"ImageFile"];
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
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.selectedQuestion objectForKey:@"imageFile"])
        {
            return 365.0;
        }
    }
    
    if (indexPath.section == 1) {
        PFObject *answer = [self.arrayAnswers objectAtIndex:indexPath.row];
        if ([answer objectForKey:@"ImageFile"]) {
            return 365.0;
        }
    }
    return 180.0;
}

- (void)changeQuestionDetail : (PFObject*) selectedQuestion
{
    //self.currentQuestion = question;
    //[question sortAnswers];
    
    self.selectedQuestion = selectedQuestion;
    //self.arrayAnswers = [question answersArray];
    
    PFQuery *answersQuery = [PFQuery queryWithClassName:@"Answer"];
    [answersQuery whereKey:@"question" equalTo:self.selectedQuestion];
    self.arrayAnswers = [answersQuery findObjects];
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
    [self.selectedQuestion incrementKey:@"upVotes" byAmount:[NSNumber numberWithInt:1]];
    [self.selectedQuestion incrementKey:@"upDownDifference" byAmount:[NSNumber numberWithInt:1]];
    [self.selectedQuestion save];
    
    [self.tableView reloadData];
    UINavigationController *VCRef = [self.splitViewController.viewControllers firstObject];
    NSArray *viewControllers = VCRef.viewControllers;
    AnsweredTableViewController *VC = [viewControllers objectAtIndex:0];
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
    AnsweredTableViewController *VC = [viewControllers objectAtIndex:0];
    [VC loadObjects];
}

- (void) positiveAnswer: (UIButton *)sender
{
    PFObject *currentAnswer = [self.arrayAnswers objectAtIndex:sender.tag];
    
    [currentAnswer incrementKey:@"upVotes" byAmount:[NSNumber numberWithInt:1]];
    [currentAnswer incrementKey:@"upDownDifference" byAmount:[NSNumber numberWithInt:1]];
    [currentAnswer save];
//    [currentAnswer setUpVotes:[currentAnswer upVotes]+1];
//    [currentAnswer setVotesDifference];
    [self.tableView reloadData];
}
- (void) negativeAnswer: (UIButton *)sender
{
    PFObject *currentAnswer = [self.arrayAnswers objectAtIndex:sender.tag];
    [currentAnswer incrementKey:@"downVotes" byAmount:[NSNumber numberWithInt:1]];
    [currentAnswer incrementKey:@"upDownDifference" byAmount:[NSNumber numberWithInt:-1]];
    [currentAnswer save];
//    [currentAnswer setDownVotes:[currentAnswer downVotes]+1];
//    [currentAnswer setVotesDifference];
    [self.tableView reloadData];
}

- (void)sortAnswers
{
    NSSortDescriptor *sDescriptor = [[NSSortDescriptor alloc]initWithKey:@"upDownDifference" ascending:NO];
    self.arrayAnswers = (NSMutableArray *)[self.arrayAnswers sortedArrayUsingDescriptors:@[sDescriptor]];
}



@end