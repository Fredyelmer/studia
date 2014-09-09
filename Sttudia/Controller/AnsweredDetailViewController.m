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
            
            if ([self.currentQuestion drawImageView].image) {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20.0, 186.0, 362.0, 204.0)];
                [imageView setBackgroundColor:[UIColor greenColor]];
                imageView.image = [self.currentQuestion drawImageView].image;
                [cell addSubview:imageView];
                
            }
            
        }
        else if (indexPath.section == 1) {
            Answer *answer = [self.arrayAnswers objectAtIndex:indexPath.row];
            [cell questionTitleLabel].text = [answer title];
            [cell questionSubjectTextView].text = [answer subject];
            [cell questionTextTextView].text = [answer text];
            [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%d", [answer upVotes]];
            [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%d", [answer downVotes]];
            
            if ([answer drawImageView].image) {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20.0, 186.0, 362.0, 204.0)];
                [imageView setBackgroundColor:[UIColor greenColor]];
                imageView.image = [answer drawImageView].image;
                [cell addSubview:imageView];
            }
        }
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.currentQuestion drawImageView].image)
        {
            return 408.0;
        }
    }
    
    if (indexPath.section == 1) {
        Answer *answer = [self.arrayAnswers objectAtIndex:indexPath.row];
        if ([answer drawImageView].image) {
            return 408.0;
        }
    }
    return 220.0;
}

- (void)changeQuestionDetail : (Question*) question
{
    
    self.arrayAnswers = [question answersArray];
    [self.tableView reloadData];

}
@end
