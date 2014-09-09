//
//  UnanswerQuestionTableViewCell.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 08/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnanswerQuestionTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *questionSubjectTextView;
@property (strong, nonatomic) IBOutlet UITextView *questionTextTextView;
@property (strong, nonatomic) IBOutlet UIButton *positiveButton;
@property (strong, nonatomic) IBOutlet UIButton *negativeButton;
@property (strong, nonatomic) IBOutlet UILabel *positiveNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *negativeNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *answerQuestionButton;
@property (strong, nonatomic) IBOutlet UIImageView *drawImageView;

- (IBAction)positiveQuestion:(id)sender;
- (IBAction)negativeQuestion:(id)sender;
- (IBAction)answerQuestion:(id)sender;
@end
