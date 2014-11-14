//
//  ResetViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 07/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ResetViewController.h"

@interface ResetViewController ()


@end

@implementation ResetViewController

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
    self.thicknessSlider.value = self.eraserBrush;
    self.thicknessLabel.text = [NSString stringWithFormat:@"%.1f", self.eraserBrush];
    [self updateBrushView:self.eraserBrush];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)eraserAll:(id)sender {
    
    [self.delegate resetAll];
}
- (IBAction)eraserTint:(id)sender {
    
    [self.delegate resetTint];
}
- (IBAction)sliderChanged:(id)sender {
    
    self.eraserBrush = self.thicknessSlider.value;
    self.thicknessLabel.text = [NSString stringWithFormat:@"%.1f", self.eraserBrush];
    
    UIGraphicsBeginImageContext(self.thicknessImageView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.eraserBrush);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.thicknessImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self updateBrushView:self.eraserBrush];

}

- (void)updateBrushView : (CGFloat)brush {
    UIGraphicsBeginImageContext(self.thicknessImageView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),brush);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.thicknessImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.delegate newThicknessBrush : brush];

}
@end
