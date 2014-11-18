//
//  PageContentViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 15/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@property NSString *textTutorial;
@end
