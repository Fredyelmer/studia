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
            [cell drawImageView].image = [self.currentQuestion drawImageView].image;
        }
        else if (indexPath.section == 1) {
            Question *question = [self.arrayAnswers objectAtIndex:indexPath.row];
            [cell questionTitleLabel].text = [question title];
            [cell questionSubjectTextView].text = [question subject];
            [cell questionTextTextView].text = [question text];
            [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%d", [question upVotes]];
            [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%d", [question downVotes]];
            [cell drawImageView].image = [question drawImageView].image;
        }
    }
    
    return cell;
}

- (void)changeQuestionDetail : (Question*) question
{
    
    self.arrayAnswers = [question answersArray];
    [self.tableView reloadData];

}
@end
