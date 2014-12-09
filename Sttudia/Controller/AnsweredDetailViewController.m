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
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    
    PFQuery *answeredQuestionsQuery = [PFQuery queryWithClassName:@"Question"];
    [answeredQuestionsQuery whereKey:@"aQuestions" equalTo:[repository answeredQuestionsList]];
    [answeredQuestionsQuery countObjectsInBackgroundWithBlock:^(int number, NSError *errror){
        if(!errror){
            if (number > 0) {
                
                [answeredQuestionsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
                    if (!error) {
                        self.selectedQuestion = object;
                        PFQuery *answersQuery = [PFQuery queryWithClassName:@"Answer"];
                        [answersQuery whereKey:@"question" equalTo:self.selectedQuestion];
                        
                        //self.arrayAnswers = [answersQuery findObjects];
                        
                        [answersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                            
                            if (!error) {
                                self.arrayAnswers = objects;
                                PFQuery *answersQuery = [PFQuery queryWithClassName:@"Answer"];
                                [answersQuery whereKey:@"question" equalTo:self.selectedQuestion];
                                
                                //self.arrayAnswers = [answersQuery findObjects];
                                
                                [answersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                                    
                                    if (!error) {
                                        self.arrayAnswers = objects;
                                    }
                                }];
                                
                            }
                        }];
                        
                    }
                    
                }];
                
            }
            else {
                self.selectedQuestion = nil;
            }
            
            [self sortAnswers];
            [self.tableView reloadData];

        }
    }];
    
//    [self sortAnswers];
//    [self.tableView reloadData];
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
        if (self.selectedQuestion) {
            return 1;
        }
        else
            return 0;
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
        sectionName = @"Resposta";
    }
    return sectionName;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    if (cell) {
        if (indexPath.section == 0) {
            [cell questionTextTextView].layer.cornerRadius = 5.0;
            [cell answerQuestionButton].layer.cornerRadius = 5.0;
            [cell drawImageView].layer.cornerRadius = 5.0;
            [cell drawImageView].clipsToBounds = YES;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = [UIColor clearColor];
            [cell setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0]];
            [cell userNameLabel].text = [self.selectedQuestion objectForKey:@"name"];
            [cell questionTitleLabel].text = [self.selectedQuestion objectForKey:@"title"];;
            [cell questionTextTextView].text = [self.selectedQuestion objectForKey:@"text"];
            [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%@", [self.selectedQuestion objectForKey:@"upVotes"]];
            [cell negativeNumberLabel].text = [NSString stringWithFormat: @"%@", [self.selectedQuestion objectForKey:@"downVotes"]];
            [[cell answerQuestionButton]setHidden:NO];
            [[cell answerQuestionButton] addTarget:self action:@selector(answerQuestion:) forControlEvents:UIControlEventTouchUpInside];
            [[cell positiveButton] addTarget:self action:@selector(positiveQuestion:) forControlEvents:UIControlEventTouchUpInside];
            //[[cell negativeButton] addTarget:self action:@selector(negativeQuestion:) forControlEvents:UIControlEventTouchUpInside];
            if ([self.selectedQuestion objectForKey:@"imageFile"]) {
                PFFile *thumbnail = [self.selectedQuestion objectForKey:@"imageFile"];
                PFImageView *thumbnailImageView = (PFImageView *)[cell drawImageView];
                thumbnailImageView.image = [UIImage imageNamed:@"placeholder.png"];
                thumbnailImageView.file = thumbnail;
                [thumbnailImageView loadInBackground];
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
                [[cell drawImageView]addGestureRecognizer:tapGesture];
                [[cell drawImageView]setHidden:NO];

            }
            else {
                [[cell drawImageView]setHidden:YES];
            }
            
        }
        else if (indexPath.section == 1) {
            PFObject *answer = [self.arrayAnswers objectAtIndex:indexPath.row];
            [cell questionTextTextView].layer.cornerRadius = 5.0;
            [cell answerQuestionButton].layer.cornerRadius = 5.0;
            [cell drawImageView].layer.cornerRadius = 5.0;
            [cell drawImageView].clipsToBounds = YES;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentView.backgroundColor = [UIColor clearColor];
            [cell setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:248.0/255.0 blue:255.0/255.0 alpha:1.0]];
            
            [cell userNameLabel].text = [answer objectForKey:@"name"];
            [cell questionTitleLabel].text = nil;
            [cell questionTextTextView].text = [answer objectForKey:@"text"];
            [cell positiveNumberLabel].text = [NSString stringWithFormat: @"%@", [answer objectForKey:@"upVotes"]];
            //[cell negativeNumberLabel].text = [NSString stringWithFormat: @"%@", [answer objectForKey:@"downVotes"]];
            
            [cell positiveButton].tag = indexPath.row;
            [[cell positiveButton] addTarget:self action:@selector(positiveAnswer:) forControlEvents:UIControlEventTouchUpInside];
            [cell negativeButton].tag = indexPath.row;
            //[[cell negativeButton] addTarget:self action:@selector(negativeAnswer:) forControlEvents:UIControlEventTouchUpInside];
            [[cell answerQuestionButton]setHidden:YES];
            if ([answer objectForKey:@"ImageFile"]) {
                PFFile *thumbnail = [answer objectForKey:@"ImageFile"];
                PFImageView *thumbnailImageView = (PFImageView *)[cell drawImageView];
                thumbnailImageView.image = [UIImage imageNamed:@"placeholder.png"];
                thumbnailImageView.file = thumbnail;
                [thumbnailImageView loadInBackground];
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
                [[cell drawImageView]addGestureRecognizer:tapGesture];
                [[cell drawImageView]setHidden:NO];
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
    return 190.0;
}

- (void)changeQuestionDetail : (PFObject*) selectedQuestion
{
    //self.currentQuestion = question;
    //[question sortAnswers];
    
    self.selectedQuestion = selectedQuestion;
    //self.arrayAnswers = [question answersArray];
    
    PFQuery *answersQuery = [PFQuery queryWithClassName:@"Answer"];
    [answersQuery whereKey:@"question" equalTo:self.selectedQuestion];
    //self.arrayAnswers = [answersQuery findObjects];
    
    [answersQuery findObjectsInBackgroundWithBlock:^(NSArray *answers, NSError *error){
        if (!error) {
            self.arrayAnswers = answers;
            [self sortAnswers];
            [self.tableView reloadData];
        }
    }];
    //[self.tableView reloadData];

}

- (void)answerQuestion: (UIButton *)sender
{
    NewQuestionViewController *newQuestionVCRef = (NewQuestionViewController *)[[self.tabBarController viewControllers] objectAtIndex:2];
    [newQuestionVCRef setCurrentQuestion:self.selectedQuestion];
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
    PFUser *user = [PFUser currentUser];
    
    if (user) {
        self.userArray = [self.selectedQuestion objectForKey:@"arrayUser"];
        
        if (!self.userArray) {
            self.userArray = [[NSMutableArray alloc]init];
        }
        
        NSString* name = [user objectForKey:@"username"];
        bool isInArray = NO;
        
        for (NSString *nameInArray in self.userArray) {
            if ([nameInArray isEqualToString:name]) {
                isInArray = YES;
            }
        }
        
        if (!isInArray) {
            [self.userArray addObject: name];
            
            [self.selectedQuestion incrementKey:@"upVotes" byAmount:[NSNumber numberWithInt:1]];
            [self.selectedQuestion addObjectsFromArray:self.userArray forKey:@"arrayUser"];
            //[self.selectedQuestion incrementKey:@"upDownDifference" byAmount:[NSNumber numberWithInt:1]];
            [self.selectedQuestion save];
            
            [self.tableView reloadData];
            UINavigationController *VCRef = [self.splitViewController.viewControllers firstObject];
            NSArray *viewControllers = VCRef.viewControllers;
            AnsweredTableViewController *VC = [viewControllers objectAtIndex:0];
            [VC loadObjects];
        }
        else {
            UIAlertView *likedAlert = [[UIAlertView alloc]initWithTitle:@"Positivado" message:@"Você já positivou a questão" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [likedAlert show];
        }

    }
    else {
        UIAlertView *logInAlert = [[UIAlertView alloc]initWithTitle:@"Acesso negado" message:@"Você precisa estar logado para positivar a questão" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [logInAlert show];
    }
    
}

- (void) positiveAnswer: (UIButton *)sender
{
    PFUser *user = [PFUser currentUser];
    
    if (user) {
        PFObject *currentAnswer = [self.arrayAnswers objectAtIndex:sender.tag];
        self.userArray = [currentAnswer objectForKey:@"arrayUser"];
        
        if (!self.userArray) {
            self.userArray = [[NSMutableArray alloc]init];
        }
        
        NSString* name = [user objectForKey:@"username"];
        bool isInArray = NO;
        
        for (NSString *nameInArray in self.userArray) {
            if ([nameInArray isEqualToString:name]) {
                isInArray = YES;
            }
        }
        
        if (!isInArray) {
            [self.userArray addObject: name];
            
            [currentAnswer incrementKey:@"upVotes" byAmount:[NSNumber numberWithInt:1]];
            [currentAnswer addObjectsFromArray:self.userArray forKey:@"arrayUser"];
            [currentAnswer save];
            //    [currentAnswer setUpVotes:[currentAnswer upVotes]+1];
            //    [currentAnswer setVotesDifference];
            [self.tableView reloadData];

//            UINavigationController *VCRef = [self.splitViewController.viewControllers firstObject];
//            NSArray *viewControllers = VCRef.viewControllers;
//            AnsweredTableViewController *VC = [viewControllers objectAtIndex:0];
//            [VC loadObjects];
        }
        else {
            UIAlertView *likedAlert = [[UIAlertView alloc]initWithTitle:@"Positivado" message:@"Você já positivou a resposta" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [likedAlert show];
        }
        
    }
    else {
        UIAlertView *logInAlert = [[UIAlertView alloc]initWithTitle:@"Acesso negado" message:@"Você precisa estar logado para positivar a resposta" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [logInAlert show];
    }

    
    
//    PFObject *currentAnswer = [self.arrayAnswers objectAtIndex:sender.tag];
//    
//    [currentAnswer incrementKey:@"upVotes" byAmount:[NSNumber numberWithInt:1]];
//    //[currentAnswer incrementKey:@"upDownDifference" byAmount:[NSNumber numberWithInt:1]];
//    [currentAnswer save];
////    [currentAnswer setUpVotes:[currentAnswer upVotes]+1];
////    [currentAnswer setVotesDifference];
//    [self.tableView reloadData];
}
//- (void) negativeAnswer: (UIButton *)sender
//{
//    PFObject *currentAnswer = [self.arrayAnswers objectAtIndex:sender.tag];
//    [currentAnswer incrementKey:@"downVotes" byAmount:[NSNumber numberWithInt:1]];
//    [currentAnswer incrementKey:@"upDownDifference" byAmount:[NSNumber numberWithInt:-1]];
//    [currentAnswer save];
////    [currentAnswer setDownVotes:[currentAnswer downVotes]+1];
////    [currentAnswer setVotesDifference];
//    [self.tableView reloadData];
//}

- (void)sortAnswers
{
    NSSortDescriptor *sDescriptor = [[NSSortDescriptor alloc]initWithKey:@"upDownDifference" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sDescriptor];
    self.arrayAnswers = (NSMutableArray *)[self.arrayAnswers sortedArrayUsingDescriptors:sortDescriptors];
}


@end
