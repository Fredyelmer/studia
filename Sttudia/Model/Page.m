//
//  Page.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 22/07/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "Page.h"

@implementation Page

- (id)initWithElements : (UIImage *)drawView : (NSMutableArray *)arrayImage : (NSMutableArray *)arrayText : (NSMutableArray *)arrayUndo : (NSMutableArray *)arrayRedo : (UIImage *)bacKGroundImage
{
    self = [super init];
    
    if(self)
    {
        self.drawView = drawView;
        self.arrayImage = arrayImage;
        self.arrayText = arrayText;
        
        if (!arrayUndo && !arrayRedo) {
            self.arrayUndo = [[NSMutableArray alloc]init];
            self.arrayRedo = [[NSMutableArray alloc]init];
        }
        else{
            self.arrayUndo = arrayUndo;
            self.arrayRedo = arrayRedo;
        }
//        self.arrayUndo = arrayUndo;
//        self.arrayRedo = arrayRedo;
        self.backGroundImage = bacKGroundImage;
    }
    
    return self;
}

@end
