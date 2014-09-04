//
//  QuestionListTableViewCell.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 02/09/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "QuestionListTableViewCell.h"

@implementation QuestionListTableViewCell

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

@end
