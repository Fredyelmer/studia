//
//  InformationViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 19/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()
@property (strong, nonatomic) IBOutlet UITextView *creditsTextView;


@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"credito"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    self.creditsTextView.text = content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backToTutorial:(id)sender {
    
    [self performSegueWithIdentifier:@"toTutorialSegue" sender:nil];
}
//metodos para forçar em landscape mode
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationMaskLandscape);
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
