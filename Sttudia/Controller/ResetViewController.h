//
//  ResetViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 07/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResetViewControllerDelegate <NSObject>

- (void) resetAll;
- (void) resetTint;

@end

@interface ResetViewController : UIViewController

@property (weak, nonatomic) id <ResetViewControllerDelegate> delegate;

@end
