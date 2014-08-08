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
#import "ColorBarPicker.h"
#import "ColorSquarePicker.h"
#import "SourceColorView.h"
#import "Page.h"
#import "ColorPickerViewController.h"
#import "ThicknessViewController.h"
#import "CorUIButton.h"
#import "ImagePickerLandscapeController.h"
#import "AddImageViewController.h"
#import "CollectionViewController.h"
#import "ResetViewController.h"
#import "FontTypeViewController.h"
#import "ColorFontViewController.h"
#import "ThicknessViewController.h"


@interface BoardViewController : UIViewController <UIActionSheetDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIWebViewDelegate, UISearchBarDelegate, ColorPickerViewControllerDelegate, UIGestureRecognizerDelegate, AddImageViewControllerDelegate, CollectionViewControllerDelegate, ResetViewControllerDelegate, FontTypeViewControllerDelegate,ColorFontViewControllerDelegate,ThicknessViewControllerDelegate>
{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat eraser;
    CGFloat opacity;
    BOOL mouseSwiped;
    
    CGFloat backGroundRed;
    CGFloat backGroundGreen;
    CGFloat backGroundBlue;
    
    int maxPageIndex;
    int currentPageIndex;
    BOOL undoMade;
}

@property (nonatomic,strong) UIPopoverController *popoverColorPicker;
@property (nonatomic,strong) UIPopoverController *popoverThickness;
@property (nonatomic,strong) UIPopoverController *popoverAddImage;
@property (strong, nonatomic) UIPopoverController *popoverEraser;
@property (strong, nonatomic) UIPopoverController *popoverFont;
@property (strong, nonatomic) UIPopoverController *popoverFontColor;

@property (strong, nonatomic) IBOutlet UIView *layoutView;
@property (strong, nonatomic) IBOutlet UIButton *thicknessButton;

@property (strong, nonatomic) IBOutletCollection(CorUIButton) NSArray *ColorButton;
@property (strong, nonatomic) IBOutlet CorUIButton *eraseButton;


@property (strong, nonatomic) IBOutlet UIButton *snapShotButtom;
@property (strong, nonatomic) IBOutlet UIButton *recAudio;
@property (strong, nonatomic) IBOutlet UIButton *pauseRecAudio;
@property (strong, nonatomic) IBOutlet UIButton *confirmImageButton;
@property (strong, nonatomic) IBOutlet UIButton *addImageButton;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;
@property (strong, nonatomic) IBOutlet UIImageView *layoutImageView;


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
@property (strong, nonatomic) IBOutlet UIButton *undoButton;
@property (strong, nonatomic) IBOutlet UIButton *redoButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) NSMutableArray* arrayUndo;
@property (strong, nonatomic) NSMutableArray* arrayRedo;
@property (strong, nonatomic) IBOutlet UIImageView *topBar;
@property (strong, nonatomic) IBOutlet UIImageView *bottonBar;


- (IBAction)startVideoRecord:(id)sender;
- (IBAction)reproduzirGravacao:(id)sender;
- (IBAction)confirmImageEdition:(id)sender;

- (IBAction)addImage:(id)sender;
- (IBAction)addText:(id)sender;
- (IBAction)erasePressed:(CorUIButton*)sender;
- (IBAction)nextPage:(id)sender;
- (IBAction)previewsPage:(id)sender;

- (IBAction)ColorPressed:(CorUIButton *)sender;
- (IBAction)changeThickness:(id)sender;


- (IBAction)setBackgroundView:(id)sender;
- (IBAction)changeLayout:(UIButton *)sender;

- (void)addImageFromLibrary;
- (void)addPhoto;
- (void)getPhotoFromInternet;
@end
