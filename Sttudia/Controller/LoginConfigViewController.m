//
//  LoginConfigViewController.m
//  Sttudia
//
//  Created by Helder Lima da Rocha on 7/3/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "LoginConfigViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface LoginConfigViewController ()

@end

@implementation LoginConfigViewController

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
    [PFFacebookUtils initializeFacebook];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if (![PFUser currentUser]) {
//        LoginViewController *loginViewController = [[LoginViewController alloc]init];
//        
//        loginViewController.delegate = self;
//        
//        loginViewController.facebookPermissions = @[@"friends_about_me"];
//        loginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton;
//        
//        // Customize the Sign Up View Controller
//        SignUpViewController *signUpViewController = [[SignUpViewController alloc]init];
//        signUpViewController.delegate = self;
//        signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
//        loginViewController.signUpController = signUpViewController;
//        
//        // Present Log In View Controller
//        [self presentViewController:loginViewController animated:YES completion:NULL];
//
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


- (IBAction)loginButtonAction:(id)sender
{
    
    if (![PFUser currentUser]) {
        //LoginViewController *loginViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"loginVC"];
        LoginViewController *loginViewController = [[LoginViewController alloc]init];
        loginViewController.delegate = self;
        
        loginViewController.facebookPermissions = @[@"public_profile"];
        loginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton;
        
        // Customize the Sign Up View Controller
        //SignUpViewController *signUpViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"signUpVC"];
        
        SignUpViewController *signUpViewController = [[SignUpViewController alloc]init];
        signUpViewController.delegate = self;
        signUpViewController.fields = PFSignUpFieldsDefault | PFSignUpFieldsAdditional;
        loginViewController.signUpController = signUpViewController;
        
        // Present Log In View Controller
        [self presentViewController:loginViewController animated:YES completion:NULL];
        
    }
    else
    {
        PFUser *user = [PFUser currentUser];
        
        UIAlertView *loginAlert = [[UIAlertView alloc]initWithTitle:@"Já esta logado" message:[NSString stringWithFormat:@"Logado como %@", [user objectForKey:@"username"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"LogOut", nil];
        
        [loginAlert show];

    
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        PFUser *user = [PFUser currentUser];
        [PFUser logOut];
        UIAlertView *loginAlert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Desconectado %@", [user objectForKey:@"username"]] message:[NSString stringWithFormat:@"%@ foi desconectado", [user objectForKey:@"username"]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [loginAlert show];
    }
}

@end
