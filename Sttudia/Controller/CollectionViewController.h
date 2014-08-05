//
//  CollectionViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 31/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoRequest.h"
#import "PhotoRepository.h"
#import "customCell.h"

@interface CollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PhotoRequestDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *photoArray;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@end


