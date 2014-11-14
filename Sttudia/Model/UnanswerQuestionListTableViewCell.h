//
//  UnanswerQuestionListTableViewCell.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 08/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnanswerQuestionListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;
@property (strong, nonatomic) IBOutlet UILabel *numPositiveLabel;
@property (strong, nonatomic) IBOutlet UILabel *numNegativeLabel;

@end

