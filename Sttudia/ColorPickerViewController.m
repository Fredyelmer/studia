//
//  ColorPickerViewController.m
//  Sttudia
//
//  Created by Fredy Arias on 31/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ColorPickerViewController.h"


@interface ColorPickerViewController ()

@end

@implementation ColorPickerViewController

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
    [self initColorPicker:self.color];
}

-(void) initColorPicker:(UIColor *) color
{
    self.resultColorButton.backgroundColor = color;
    self.sourceColorButton.backgroundColor = color;
    
    [color getHue:&_hue saturation:&_saturation brightness:&_brightness alpha:&opacity];
    self.barPicker.value = _hue;
    self.squarePicker.hue = _hue;
    self.squarePicker.value = CGPointMake(_saturation, _brightness);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)takeSquareValue:(ColorSquarePicker *)sender
{
    _saturation = sender.value.x;
    _brightness = sender.value.y;
    
    [self.delegate newColorBrush:[self updateResultColor]];
}

- (IBAction)takeBarValue:(ColorBarPicker *)sender

{
    _hue = sender.value;
	_squarePicker.hue = _hue;
	
	[self.delegate newColorBrush:[self updateResultColor]];
}

- (IBAction)setResultColor:(id)sender
{
    //[_colorPicker setHidden:YES];
}

- (IBAction)setSourceColor:(CorUIButton*)sender
{
    [self.delegate newColorBrush:[self updateResultColor]];
    [self initColorPicker:sender.backgroundColor];
}

- (IBAction)setCustomColor:(CorUIButton *)sender
{
    [self.delegate newColorBrush:[self updateResultColor]];
    [self initColorPicker:sender.backgroundColor];
}

- (UIColor *) updateResultColor
{
    UIColor *color = [UIColor colorWithHue: _hue saturation: _saturation brightness: _brightness alpha: 1.0f];
    self.resultColorButton.backgroundColor = color;
    return color;
}

- (IBAction)closeColorPicker:(id)sender
{
    [self.delegate dismissColorPicker];
}
@end
