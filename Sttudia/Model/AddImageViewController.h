//
//  AddImageViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 05/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerLandscapeController.h"

@protocol AddImageViewControllerDelegate

- (void) addImageFromLibrary;
- (void) addPhoto;
- (void) getPhotoFromInternet;


@end

@interface AddImageViewController : UIViewController

@property (nonatomic, weak) id<AddImageViewControllerDelegate> delegate;

@property (strong, nonatomic) UIImageView *tempImageView;

@property (strong, nonatomic) NSMutableArray* arrayImages;

@end
