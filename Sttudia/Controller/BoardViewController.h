//
//  BoardViewController.h
//  Sttudia
//
//  Created by Fredy Arias on 30/06/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CorUIButton.h"

@interface BoardViewController : UIViewController <UIActionSheetDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}

//comentario de teste
@property (strong, nonatomic) IBOutlet CorUIButton *cor1UIButton;
@property (strong, nonatomic) IBOutlet CorUIButton *cor2UIButton;
@property (strong, nonatomic) IBOutlet CorUIButton *cor3UIButton;
@property (strong, nonatomic) IBOutlet CorUIButton *cor4UIButton;
@property (strong, nonatomic) IBOutlet CorUIButton *cor5UIButton;
@property (strong, nonatomic) IBOutlet UIButton *snapShotButtom;
@property (strong, nonatomic) IBOutlet UIButton *recAudio;
@property (strong, nonatomic) IBOutlet UIButton *pauseRecAudio;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;
@property (strong, nonatomic) NSMutableArray* arraySnapshots;
@property (strong, nonatomic) IBOutlet UIButton *takeSnapshot;
@property (strong, nonatomic) IBOutlet UIImageView *drawView;

- (IBAction)corPressed:(id)sender;
@end
