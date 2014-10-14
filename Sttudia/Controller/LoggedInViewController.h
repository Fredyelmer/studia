//
//  LoggedInViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 13/10/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface LoggedInViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
- (IBAction)logOut:(id)sender;
- (IBAction)beginClass:(id)sender;

@end
