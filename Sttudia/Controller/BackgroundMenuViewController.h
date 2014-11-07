//
//  BackgroundMenuViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 03/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackgroundMenuViewControllerDelegate <NSObject>

- (void) changeBackground:(NSString*)name;

@end

@interface BackgroundMenuViewController : UIViewController

@property (nonatomic, weak) id<BackgroundMenuViewControllerDelegate> delegate;

- (IBAction)chooseBackground:(UIButton*)sender;
@end
