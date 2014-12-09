//
//  InitialViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 13/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.alpha = 0.0;
    
    PFUser *user = [PFUser currentUser];
    if (user) {
        
//        [classRepository get]
    }
    
    [UIView animateWithDuration:2.0 delay:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        self.titleLabel.alpha += 1;
    } completion:^(BOOL finished){
        if (finished) {
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"])
            {
                [self performSegueWithIdentifier:@"TutorialSegue" sender:nil];
            }
            else{
                [self performSegueWithIdentifier:@"continueSegue" sender:nil];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationMaskLandscape);
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
@end
