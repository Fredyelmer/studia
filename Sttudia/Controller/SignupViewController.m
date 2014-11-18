//
//  SignupViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 13/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.returnKeyType = UIReturnKeyDone;
    [self.emailTextField setDelegate:self];
    self.userNameTextField.returnKeyType = UIReturnKeyDone;
    [self.userNameTextField setDelegate:self];
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    [self.passwordTextField setDelegate:self];
    self.signupButton.layer.cornerRadius = 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.emailTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
- (IBAction)createUser:(id)sender {
    
    PFUser *user = [PFUser user];
    user.email = self.emailTextField.text;
    user.username = self.userNameTextField.text;
    user.password = self.passwordTextField.text;
    if (self.categorySegmentedControl.selectedSegmentIndex == 0) {
        [user setObject:@"Teacher" forKey:@"category"];
    }
    else{
        [user setObject:@"Student" forKey:@"category"];
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            UIAlertView *alertViewSignupSuccess = [[UIAlertView alloc] initWithTitle:@"Sucesso! Obrigado por cadastrar-se!"
                                                                             message:@"Aperte OK para começar"
                                                                            delegate:self
                                                                   cancelButtonTitle:@"Ok"
                                                                   otherButtonTitles:nil];
            [alertViewSignupSuccess show];
        } else {
            UIAlertView *alertViewLoginFailure = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %@", [error localizedDescription]]
                                                                            message:@"Por favor tente entrar com suas informações novamente"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"Ok" 
                                                                  otherButtonTitles:nil];
            [alertViewLoginFailure show];
        }
    }];
    
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        PFUser *currentUser = [PFUser currentUser];
        if (currentUser) {
            
            [self performSegueWithIdentifier:@"signedUpSegue" sender:self];
            
        }
        else {
            NSLog(@"failure");
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.emailTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    [self createUser:nil];
    return YES;
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
