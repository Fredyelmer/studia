//
//  UnanswerQuestionTableViewCell.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 08/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "UnanswerQuestionTableViewCell.h"

@implementation UnanswerQuestionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)positiveQuestion:(id)sender {
}

- (IBAction)negativeQuestion:(id)sender {
}

- (IBAction)answerQuestion:(id)sender {
    
}

@end
