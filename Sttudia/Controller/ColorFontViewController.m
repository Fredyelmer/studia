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
    for (UIButton *button in self.colorButton) {
        if ([button.backgroundColor isEqual:self.fontColor]) {
            button.layer.borderColor = [[UIColor yellowColor]CGColor];
        }
        else {
            button.layer.borderColor = [[UIColor blackColor]CGColor];
        }
    }

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
        case 5:
            [self.delegate setTextColor:[UIColor magentaColor]];
            break;
        case 6:
            [self.delegate setTextColor:[UIColor cyanColor]];
            break;
        case 7:
            [self.delegate setTextColor:[UIColor purpleColor]];
            break;
        case 8:
            [self.delegate setTextColor:[UIColor whiteColor]];
            break;
        default:
            break;
    }
    self.fontColor = button.backgroundColor;
    
    [self selectButton:button.backgroundColor];
}
- (void) selectButton : (UIColor*) selectedColor {
    
    for (UIButton *button in self.colorButton) {
        if ([button.backgroundColor isEqual:selectedColor]) {
            button.layer.borderColor = [[UIColor yellowColor]CGColor];
        }
        else {
            button.layer.borderColor = [[UIColor blackColor]CGColor];
        }
    }
    
}

@end
