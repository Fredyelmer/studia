//
//  ThicknessViewController.h
//  Sttudia
//
//  Created by Fredy Arias on 04/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ThicknessViewControllerDelegate

-(void) newThicknessBrush:(CGFloat) thickness;

@end

@interface ThicknessViewController : UIViewController

@property CGFloat brush;
@property CGFloat opacity;
@property CGFloat alpha;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;

@property (nonatomic) UIColor* color;

@property (nonatomic, strong) id<ThicknessViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UISlider *thicknessSlider;
@property (strong, nonatomic) IBOutlet UILabel *ThicknessValueLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ThicknessImageView;

- (IBAction)sliderChanged:(id)sender;

@end
