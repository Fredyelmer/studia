//
//  ImageDetailViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 11/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface ImageDetailViewController : UIViewController
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet PFImageView *zoomImageView;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UINavigationItem *backButton;

- (IBAction)backToPreviewView:(id)sender;

@end
