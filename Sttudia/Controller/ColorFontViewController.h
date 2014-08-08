//
//  ColorFontViewController.h
//  Sttudia
//
//  Created by Ricardo Nagaishi on 08/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorFontViewControllerDelegate <NSObject>

- (void) setTextColor : (UIColor*)textColor;

@end

@interface ColorFontViewController : UIViewController

@property (weak, nonatomic) id <ColorFontViewControllerDelegate> delegate;


@end
