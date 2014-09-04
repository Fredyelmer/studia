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
    
    [self.titleTextField becomeFirstResponder];
    
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



@end
