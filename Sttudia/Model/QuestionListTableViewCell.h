//
//  QuestionListTableViewCell.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 02/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol QuestionListTableViewCellDelegate <NSObject>
//
//- (void) changeQuestionDetail : (Question *)question;
//
//@end

@interface QuestionListTableViewCell : UITableViewCell
//@property (weak, nonatomic) id<QuestionListTableViewCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numPositiveLabel;
@property (strong, nonatomic) IBOutlet UILabel *numNegativeLabel;

@end
