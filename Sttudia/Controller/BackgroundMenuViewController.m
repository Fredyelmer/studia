//
//  BackgroundMenuViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 03/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "BackgroundMenuViewController.h"

@interface BackgroundMenuViewController ()

@end

@implementation BackgroundMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseBackground:(UIButton *)sender {
    
    [self.delegate changeBackground:sender.titleLabel.text];
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
