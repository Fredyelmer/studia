//
//  ClassesViewController.h
//  Sttudia
//
//  Created by Helder Lima da Rocha on 7/3/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ClassesCollectionViewCell.h"
#import "AddNewClassViewController.h"
#import "BoardViewController.h"

@interface ClassesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, AddNewClassViewControllerDelegate, UIPopoverControllerDelegate, UIAlertViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *classArray;
@property (strong, nonatomic) PFObject *classRepository;
@property (strong, nonatomic) UIPopoverController* popoverNewClass;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (strong, nonatomic) PFObject *objectClass;

- (IBAction)newClass:(id)sender;
- (IBAction)performSearch:(id)sender;

@end
