//
//  HomeViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 13/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface HomeViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *loginFacebookButton;
@property (strong, nonatomic) IBOutlet UIButton *loginTwitterButton;
- (IBAction)loginWithFacebook:(id)sender;
- (IBAction)loginWithTwitter:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)signUp:(id)sender;

@end
