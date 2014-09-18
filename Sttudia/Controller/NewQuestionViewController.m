//
//  NewQuestionViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 28/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "NewQuestionViewController.h"

@interface NewQuestionViewController ()
{
    CGPoint lastPoint;
    BOOL isEraser;
    CGFloat brush;
}
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *subjectTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendToEveryoneButton;
@property (strong, nonatomic) IBOutlet UIButton *sendToTeacherButton;
@property (strong, nonatomic) IBOutlet UIButton *sendAnswerButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation NewQuestionViewController

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
    // Do any additional setup after loading the view.
    self.textView.text = nil;
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.textView.delegate = self;
    self.titleTextField.delegate = self;
    self.subjectTextField.delegate = self;
    isEraser = NO;
    
    if (!self.isAnswer) {
        [self.sendAnswerButton setHidden:YES];
        [self.sendToEveryoneButton setHidden:NO];
        [self.sendToTeacherButton setHidden:NO];
    }
    else {
        [self.sendToEveryoneButton setHidden:YES];
        [self.sendToTeacherButton setHidden:YES];
        [self.sendAnswerButton setHidden:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.isAnswer) {
        [self.sendAnswerButton setHidden:YES];
        [self.sendToEveryoneButton setHidden:NO];
        [self.sendToTeacherButton setHidden:NO];
        [self.titleTextField setHidden:NO];
        [self.titleLabel setHidden:NO];
    }
    else {
        [self.sendToEveryoneButton setHidden:YES];
        [self.sendToTeacherButton setHidden:YES];
        [self.sendAnswerButton setHidden:NO];
        [self.titleTextField setHidden:YES];
        [self.titleLabel setHidden:YES];
    }
    
    self.titleTextField.text = nil;
    self.subjectTextField.text = nil;
    self.textView.text = nil;
    self.imageView.image = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
    [self.titleTextField resignFirstResponder];
    [self.subjectTextField resignFirstResponder];
    
    
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.imageView];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.imageView];
    
    UIGraphicsBeginImageContext(self.imageView.frame.size);
    [self.imageView.image drawInRect:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, 1.0);
    
    if (isEraser) {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 10.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeClear);

    }
    else {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    }
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    lastPoint = currentPoint;
}
- (IBAction)setPencil:(id)sender {
    isEraser = NO;
    
}
- (IBAction)setEraser:(id)sender {
    
    isEraser = YES;
}
- (IBAction)resetCanvas:(id)sender {
    
    self.imageView.image = nil;
    isEraser = NO;
}

# pragma mark - textField/textView delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    //[self resignFirstResponder];
    return YES;
}

- (IBAction)dismissScreen:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendQuestionToEveryone:(id)sender {
//    Question * question = [[Question alloc]initWithAuthor:@"Autor generico" title:self.titleTextField.text text:self.textView.text image:self.imageView.image];
//    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
//    [repository addUnansweredQuestion:question];
//    
//    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enviado!" message:@"Sua pergunta foi enviada para todos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [message show];
//    [self.tabBarController setSelectedIndex:0];
    
    PFObject *question = [PFObject objectWithClassName:@"Question"];
    [question setObject:@"Autor Generico" forKey:@"name"];
    [question setObject:self.titleTextField.text forKey:@"title"];
    [question setObject:self.textView.text forKey:@"text"];
    [question setObject:[NSNumber numberWithInt:0] forKey:@"upVotes"];
    [question setObject:[NSNumber numberWithInt:0] forKey:@"downVotes"];
    [question setObject:[NSNumber numberWithInt:0] forKey:@"upDownDifference"];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"%@.png", self.titleTextField.text];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [question setObject:imageFile forKey:@"imageFile"];
    
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    PFObject *uQuestion = [[repository unansweredQuestionsQuery] getFirstObject];
    [question setObject: uQuestion forKey:@"uQuestions"];
    
    [question saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enviado!" message:@"Sua pergunta foi enviada para todos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [message show];
                [self.tabBarController setSelectedIndex:0];
            
            
            //Notify table view to reload the recipes from Parse cloud
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
            
        
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];

    
}
- (IBAction)sendQuestionToTeacher:(id)sender {
    
}

- (IBAction)sendAnswer:(id)sender {
    
    Answer *answer = [[Answer alloc]initWithAuthor:@"AutorGenerico" text:self.titleTextField.text image:self.imageView.image];
    
    
    [self.currentQuestion.answersArray addObject:answer];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enviado!" message:@"Sua resposta foi enviada com sucesso!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [message show];
    
    QuestionsRepository *repository = [QuestionsRepository sharedRepository];
    
    if ([[repository unansweredQuestionsArray] containsObject:self.currentQuestion]) {
        [[repository unansweredQuestionsArray]removeObject:self.currentQuestion];
        [[repository answeredQuestionsArray]addObject:self.currentQuestion];
    }
    self.isAnswer = NO;
    [self.tabBarController setSelectedIndex:1];
}

@end
