//
//  ColorPickerViewController.h
//  Sttudia
//
//  Created by Fredy Arias on 31/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorUIButton.h"
#import "ColorBarPicker.h"
#import "ColorSquarePicker.h"

@protocol ColorPickerViewControllerDelegate

-(void) newColorBrush:(UIColor *) newColor;
-(void) dismissColorPicker;

@end

@interface ColorPickerViewController : UIViewController
{
    CGFloat _hue;
	CGFloat _saturation;
	CGFloat _brightness;
    CGFloat opacity;
}

@property (nonatomic, weak) id<ColorPickerViewControllerDelegate> delegate;

@property (nonatomic) UIColor* color;

@property (strong, nonatomic) IBOutlet CorUIButton *resultColorButton;
@property (strong, nonatomic) IBOutlet CorUIButton *sourceColorButton;

@property (nonatomic) IBOutlet ColorBarPicker* barPicker;
@property (strong, nonatomic) IBOutlet ColorSquarePicker *squarePicker;


- (IBAction)closeColorPicker:(id)sender;
@end
