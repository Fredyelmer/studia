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
#import "ColorPickerView.h"
#import "ColorBarPicker.h"
#import "ColorSquarePicker.h"
#import "SourceColorView.h"
#import "Page.h"


@interface BoardViewController : UIViewController <UIActionSheetDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate>
{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    
    CGFloat backGroundRed;
    CGFloat backGroundGreen;
    CGFloat backGroundBlue;
    
    NSInteger selectedButton;
    
    int maxPageIndex;
    int currentPageIndex;
}

//comentario de teste
@property (strong, nonatomic) IBOutlet ColorPickerView *colorPicker;

@property (nonatomic) UIColor* sourceColor;
@property (nonatomic) UIColor* resultColor;
@property (strong, nonatomic) IBOutlet CorUIButton *resultColorButton;
@property (strong, nonatomic) IBOutlet CorUIButton *sourceColorButton;

@property (nonatomic) IBOutlet ColorBarPicker* barPicker;
@property (strong, nonatomic) IBOutlet ColorSquarePicker *squarePicker;

@property (strong, nonatomic) IBOutletCollection(CorUIButton) NSArray *ColorButton;

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
@property (strong, nonatomic) NSMutableArray* arrayTexts;
@property (strong, nonatomic) UITextField* currentTextField;
@property (strong, nonatomic) NSMutableArray* arrayPages;
@property (strong, nonatomic) IBOutlet UILabel *pageNumberLabel;

- (IBAction)startVideoRecord:(id)sender;
- (IBAction)reproduzirGravacao:(id)sender;
- (IBAction)confirmImageEdition:(id)sender;

- (IBAction)addImage:(id)sender;
- (IBAction)addText:(id)sender;
- (IBAction)erasePressed:(id)sender;
- (IBAction)nextPage:(id)sender;
- (IBAction)previewsPage:(id)sender;

- (IBAction)takeBarValue:(ColorBarPicker *)sender;
- (IBAction)ColorPressed:(CorUIButton *)sender;
- (IBAction)setResultColor:(id)sender;
- (IBAction)setSourceColor:(id)sender;
- (IBAction)setCustomColor:(CorUIButton *)sender;

@end
