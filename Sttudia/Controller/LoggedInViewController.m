//
//  LoggedInViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 13/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "LoggedInViewController.h"

@interface LoggedInViewController ()

@end

@implementation LoggedInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    PFUser *user = [PFUser currentUser];
    
    
    BOOL linkedWithFacebook = [PFFacebookUtils isLinkedWithUser:user];
    BOOL linkedWithTwitter = [PFTwitterUtils isLinkedWithUser:user];
    
    if (!linkedWithFacebook && !linkedWithTwitter) {
        self.userNameLabel.text = [NSString stringWithFormat:@"Bem Vindo %@", [user objectForKey:@"username"]];
    }
    else if (linkedWithFacebook) {
        FBRequest *request = [FBRequest requestForMe];
        [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSDictionary *userData = (NSDictionary *)result;
                NSString *userName = userData[@"name"];
                self.userNameLabel.text = userName;
            }}];
    }
    else if (linkedWithTwitter) {
        NSString *twitterUsername = [[PFTwitterUtils twitter] screenName];
        self.userNameLabel.text = twitterUsername;
    }
    
    
    NSString *category = [user objectForKey:@"category"];
    if (category) {
        self.categoryLabel.text = category;
    }
    else {
        self.categoryLabel.text = @"Student";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logOut:(id)sender {
    
    PFUser *user = [PFUser currentUser];
    
    NSLog(@"%@", [user objectForKey:@"category"]);
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"loggedOutSegue" sender:self];
}

- (IBAction)beginClass:(id)sender {
    
    [self performSegueWithIdentifier:@"classSegue1" sender:nil];
}
@end
