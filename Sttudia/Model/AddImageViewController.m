//
//  AddImageViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 05/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "AddImageViewController.h"

@interface AddImageViewController ()
{
    float lastScale;
    CGPoint centerImage;
    CGFloat lastRotation;
}

@end

@implementation AddImageViewController

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

- (IBAction)addSavedPhoto:(id)sender {
    
    NSLog(@"tt");
    [self.delegate addImageFromLibrary];
    
}
- (IBAction)takePhoto:(id)sender {
    
    [self.delegate addPhoto];
}

- (IBAction)getPhotoInternet:(id)sender {

    [self.delegate getPhotoFromInternet];
}



@end
