//
//  ClassesCollectionViewCell.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 30/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ClassesCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet PFImageView *pfimageView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *author;

@property (strong, nonatomic) IBOutlet UILabel *name;


@end
