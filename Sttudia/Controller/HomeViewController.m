//
//  HomeViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 13/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.usernameTextField.returnKeyType = UIReturnKeyDone;
    [self.usernameTextField setDelegate:self];
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    [self.passwordTextField setDelegate:self];
    self.loginButton.layer.cornerRadius = 5.0;
    self.loginFacebookButton.layer.cornerRadius = 5.0;
    self.loginTwitterButton.layer.cornerRadius = 5.0;
    //[PFUser logOut];
}

//- (void)viewDidAppear:(BOOL)animated {
//    
//    [super viewDidAppear:animated];
//    
//    PFUser *currentUser = [PFUser currentUser];
//    if (currentUser) {
//        // do stuff with the user
//        [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
//    } else {
//        // show the signup or login screen
//    }
//}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
    } else {
        // show the signup or login screen
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

- (IBAction)loginWithFacebook:(id)sender {
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships"];
    
    
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [self.activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
            } else {
                NSLog(@"User with facebook logged in!");
            }
            [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
        }
    }];
    
    [self.activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (IBAction)loginWithTwitter:(id)sender {
    
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        [self.activityIndicator stopAnimating];
        
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else {
            if (user.isNew) {
                NSLog(@"User signed up and logged in with Twitter!");
            } else {
                NSLog(@"User logged in with Twitter!");
            }
            [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
   
        }
    }];
    
    [self.activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (IBAction)login:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
        // Do stuff after successful login.
            NSLog(@"Success");
            [self performSegueWithIdentifier:@"loggedInSegue" sender:self];
        } else {
            // The login failed. Check error to see why.
            NSLog(@"Failure");
            UIAlertView *alertViewLoginFailure = [[UIAlertView alloc] initWithTitle:@"Seus credenciais de login estão errados" message:@"Por favor entre com as suas informações novamente" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                            
            [alertViewLoginFailure show];
        }
    }];
}

- (IBAction)forgotPassword:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Endereço de E-mail"
                                                        message:@"Insira seu endereço de e-mail cadastrado:"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancelar"
                                              otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];

}

- (IBAction)signUp:(id)sender {
    
    [self performSegueWithIdentifier:@"signUpSegue" sender:nil];
}

- (IBAction)unwindSegueToLogin: (UIStoryboardSegue *)segue {
    
    // Do Something With the Segue if Desired
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    [self login:nil];
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        
        UITextField *emailAddress = [alertView textFieldAtIndex:0];
        
        [PFUser requestPasswordResetForEmailInBackground: emailAddress.text];
        
        UIAlertView *alertViewSuccess = [[UIAlertView alloc] initWithTitle:@"Sucesso! Um e-mail de redefinição de senha foi enviado para você" message:@""
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
        [alertViewSuccess show];
    }
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
