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
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    self.currentQuestion = [[repository answeredQuestionsArray]objectAtIndex:0];
    self.arrayAnswers = [self.currentQuestion answersArray];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    self.currentQuestion = [[repository answeredQuestionsArray]objectAtIndex:0];
    self.arrayAnswers = [self.currentQuestion answersArray];
    
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
            [cell questionTitleLabel].text = [self.currentQuestion title];
            [cell questionSubjectTextView].text = [self.currentQuestion subject];
            [cell questionTextTextView].text = [self.currentQuestion text];
            [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%d", [self.currentQuestion upVotes]];
            [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%d", [self.currentQuestion downVotes]];
            [[cell answerQuestionButton]setHidden:NO];
            [[cell answerQuestionButton] addTarget:self action:@selector(answerQuestion:) forControlEvents:UIControlEventTouchUpInside];
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
        else if (indexPath.section == 1) {
            Answer *answer = [self.arrayAnswers objectAtIndex:indexPath.row];
            [cell questionTitleLabel].text = [answer title];
            [cell questionSubjectTextView].text = [answer subject];
            [cell questionTextTextView].text = [answer text];
            [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%d", [answer upVotes]];
            [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%d", [answer downVotes]];
            [[cell answerQuestionButton]setHidden:YES];
            if ([answer drawImage]) {
                [cell drawImageView].image = [answer drawImage];
                [[cell drawImageView]setHidden:NO];
                [[cell drawImageView] setUserInteractionEnabled:YES];
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
        if ([self.currentQuestion drawImage])
        {
            return 408.0;
        }
    }
    
    if (indexPath.section == 1) {
        Answer *answer = [self.arrayAnswers objectAtIndex:indexPath.row];
        if ([answer drawImage]) {
            return 408.0;
        }
    }
    return 220.0;
}

- (void)changeQuestionDetail : (Question*) question
{
    self.currentQuestion = question;
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

@end
