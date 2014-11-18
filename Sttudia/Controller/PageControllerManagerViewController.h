//
//  PageControllerManagerViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 15/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface PageControllerManagerViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray  *pageTitles;
@property (strong, nonatomic) NSArray  *pageImages;
@property (strong, nonatomic) NSArray  *pageTexts;


@end
