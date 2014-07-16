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
#import "VideoParameter.h"


@interface BoardViewController : UIViewController <UIActionSheetDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UIImagePickerControllerDelegate>
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
@property (strong, nonatomic) IBOutlet UIButton *confirmImageButton;
@property (strong, nonatomic) IBOutlet UIButton *addImageButton;
@property (strong, nonatomic) UIImage* choseImage;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;
@property (strong, nonatomic) NSMutableArray* arraySnapshots;
@property (strong, nonatomic) IBOutlet UIButton *takeSnapshot;

@property (strong, nonatomic) NSTimer* snapshotTimer;
@property (strong, nonatomic) NSMutableArray* arrayPoints;

@property (assign, nonatomic) NSTimeInterval lastTouch;
@property (assign, nonatomic) NSTimeInterval lastTimeTouch;
@property (assign, nonatomic) NSTimeInterval initialTimeInterval;
@property (strong, nonatomic) NSMutableArray* arrayImages;

- (IBAction)startVideoRecord:(id)sender;
- (IBAction)reproduzirGravacao:(id)sender;
- (IBAction)confirmImageEdition:(id)sender;


- (IBAction)corPressed:(id)sender;
- (IBAction)addImage:(id)sender;
- (IBAction)addText:(id)sender;

@end
