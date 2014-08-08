//
//  FontTypeViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 08/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FontTypeViewControllerDelegate <NSObject>

- (void) setFontType : (NSString*)fontName;

@end

@interface FontTypeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<FontTypeViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *fontRepository;

@end
