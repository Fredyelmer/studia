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
    
    for (int i = 0; i < self.colorArray.count; i++) {
        [[self.colorButton objectAtIndex:i] setBackgroundColor: [self.colorArray objectAtIndex:i]];
        
    }
    if (!self.selectedButton) {
        self.selectedButton = [self.colorButton objectAtIndex:0];
        
    }
    else
    {
        self.selectedButton = [self.colorButton objectAtIndex:self.selectedButton.tag];
    }
    self.selectedButton.layer.borderColor = [[UIColor yellowColor]CGColor];

}

-(void) initColorPicker:(UIColor*) color
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

- (IBAction)takeSquareValue:(ColorSquarePicker *)sender
{
    _saturation = sender.value.x;
    _brightness = sender.value.y;
    
    [self.delegate newColorBrush:[self updateResultColor] : self.colorArray : self.selectedButton];
}

- (IBAction)takeBarValue:(ColorBarPicker *)sender

{
    _hue = sender.value;
	_squarePicker.hue = _hue;
	
    [self.delegate newColorBrush:[self updateResultColor] : self.colorArray : self.selectedButton];
}

- (IBAction)setResultColor:(id)sender
{
    //[_colorPicker setHidden:YES];
}

- (IBAction)setSourceColor:(CorUIButton*)sender
{
    [self initColorPicker:sender.backgroundColor];
    UIColor *color = [self updateResultColor];
    [self.delegate newColorBrush:color : self.colorArray: self.selectedButton];
}

- (IBAction)setCustomColor:(CorUIButton *)sender
{
    self.selectedButton = [self.colorButton objectAtIndex: sender.tag];
    [self initColorPicker:self.selectedButton.backgroundColor];
    self.color = [self updateResultColor];
    [self.delegate newColorBrush:self.color : self.colorArray : self.selectedButton];
    //[self initColorPicker:self.selectedButton.backgroundColor];
    
    for (UIButton *button in self.colorButton) {
        button.layer.borderColor = [[UIColor blackColor]CGColor];
    }
    self.selectedButton.layer.borderColor = [[UIColor yellowColor]CGColor] ;
    
}

- (UIColor *) updateResultColor
{
    UIColor *color = [UIColor colorWithHue: _hue saturation: _saturation brightness: _brightness alpha: 1.0f];
    self.color = color;
    self.selectedButton.backgroundColor = color;
    self.resultColorButton.backgroundColor = color;
    
    NSLog(@"TAG : %ld", (long)self.selectedButton.tag);
    [self.colorArray replaceObjectAtIndex:self.selectedButton.tag withObject:color];
    
    return color;
}

- (IBAction)closeColorPicker:(id)sender
{
    [self.delegate dismissColorPicker];
}
@end
