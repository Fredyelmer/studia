//
//  AddNewClassViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 30/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "AddNewClassViewController.h"

@interface AddNewClassViewController ()

@end

@implementation AddNewClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.classNameTextField.delegate = self;
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

- (IBAction)createClass:(id)sender {
    
    [self.delegate createNewClass: self.classNameTextField.text];
    [self.classNameTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.delegate createNewClass: self.classNameTextField.text];
    [self.classNameTextField resignFirstResponder];
    return YES;
}


@end
