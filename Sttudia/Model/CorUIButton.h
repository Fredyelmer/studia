//
//  CorUIButton.h
//  Sttudia
//
//  Created by Fredy Arias on 01/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CorUIButton : UIButton

@property Boolean state;

- (void)initialise;
- (void) buttonPressed;

@end
