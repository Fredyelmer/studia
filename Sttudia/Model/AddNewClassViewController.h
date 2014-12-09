//
//  AddNewClassViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 30/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddNewClassViewControllerDelegate
- (void) createNewClass: (NSString*) nameClass;
@end

@interface AddNewClassViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, weak) id<AddNewClassViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *classNameTextField;

- (IBAction)createClass:(id)sender;

@end
