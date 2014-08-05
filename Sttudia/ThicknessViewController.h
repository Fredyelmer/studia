//
//  ThicknessViewController.h
//  Sttudia
//
//  Created by Fredy Arias on 04/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThicknessViewController : UIViewController
{
    CGFloat red;
	CGFloat green;
	CGFloat blue;
    CGFloat opacity;
}
@property (nonatomic) UIColor* color;

@property (strong, nonatomic) IBOutlet UISlider *thicknessSlider;
@property (strong, nonatomic) IBOutlet UILabel *ThicknessValueLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ThicknessImageView;

@property (strong, nonatomic) IBOutlet UISlider *opacitySlider;
@property (strong, nonatomic) IBOutlet UILabel *opacityValueLabel;
@property (strong, nonatomic) IBOutlet UIImageView *opacityImageView;

@property CGFloat brush;
@property CGFloat opacity;

- (IBAction)sliderChanged:(id)sender;

@end
