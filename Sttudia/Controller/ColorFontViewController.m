//
//  ColorFontViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 08/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ColorFontViewController.h"

@interface ColorFontViewController ()

@end

@implementation ColorFontViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeColor:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    switch ([button tag]) {
        case 0:
            [self.delegate setTextColor:[UIColor redColor]];
            break;
        case 1:
            [self.delegate setTextColor:[UIColor blueColor]];
            break;
        case 2:
            [self.delegate setTextColor:[UIColor greenColor]];
            break;
        case 3:
            [self.delegate setTextColor:[UIColor yellowColor]];
            break;
        case 4:
            [self.delegate setTextColor:[UIColor blackColor]];
            break;
        default:
            break;
    }
}

@end
