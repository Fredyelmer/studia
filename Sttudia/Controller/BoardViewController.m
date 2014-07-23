//
//  BoardViewController.m
//  Sttudia
//
//  Created by Fredy Arias on 30/06/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "BoardViewController.h"
#import "CorUIButton.h"
#import "ImagePickerLandscapeController.h"

@interface BoardViewController ()
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSTimeInterval totalInterval;
    BOOL isScreenTouched;
    BOOL isImageEditing;
    int indexImage;
    BOOL isEraser;
    BOOL finishTextEdit;
    UIImageView *currentImage;
}

@property (assign, nonatomic) BOOL isRecording;

@end

@implementation BoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 5.0;
    opacity = 1.0;
    
    backGroundRed = 255.0/255.0;
    backGroundGreen = 255.0/255.0;
    backGroundBlue = 255.0/255.0;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:backGroundRed green:backGroundGreen blue:backGroundBlue alpha:1]];
    
    self.arraySnapshots = [[NSMutableArray alloc]init];
    self.arrayPoints = [[NSMutableArray alloc]init];
    self.isRecording = NO;
    
    [self.recAudio setEnabled:YES];
    [self.pauseRecAudio setHidden:YES];
    [self.pauseRecAudio setEnabled:YES];
    
    
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],@"MyAudioMemo.m4a",nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    isScreenTouched = NO;
    isEraser = NO;
    
    self.lastTimeTouch = 0;
    
    totalInterval = 0;
    indexImage = 0;
    
    self.arrayImages = [[NSMutableArray alloc]init];
    self.arrayPages = [[NSMutableArray alloc]init];
    self.arrayTexts = [[NSMutableArray alloc]init];
    
    self.addImageButton.enabled = YES;
    self.addImageButton.hidden = NO;
    self.confirmImageButton.enabled = NO;
    self.confirmImageButton.hidden = YES;
    
    finishTextEdit = YES;
    
    maxPageIndex = 0;
    currentPageIndex = 0;
    
    self.pageNumberLabel.text = [NSString stringWithFormat:@"%d",currentPageIndex];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(BOOL)prefersStatusBarHidden { return YES; }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startVideoRecord:(id)sender {
    
    
    if (!self.isRecording) {
        self.isRecording = YES;
        
        //inicia a gravação de aúdio
        if(player.playing) {
            [player stop];
        }
        
        if(!recorder.recording){
            AVAudioSession *session = [AVAudioSession sharedInstance];
            [session setActive:YES error:nil];
            
            // Start recording
            [recorder record];
            //[recordPauseButton setTitle:@"Pause" forStateUIControlStateNormal];
        }

    }
    else{
        
        //termina a gravação de aúdio
        [recorder stop];
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        
        
        self.isRecording = NO;
    }
}

- (IBAction)reproduzirGravacao:(id)sender {
    
    self.tempImageView.image = nil;
    
    for (int i = 0; i < [self.arrayPoints count]; i++) {
        
        if ([self.arrayPoints[i] isDrawing]){
            [self performSelector:@selector(draw:) withObject:self.arrayPoints[i] afterDelay:[self.arrayPoints[i] interval]];
        }
    }
}

-(void)chamada{
    
    UIImage *image = [self snapshot:self.tempImageView];
    [self.arraySnapshots addObject:image];
    NSLog(@"tirou foto");
}

- (IBAction)corPressed:(id)sender
{
    CorUIButton * PressedButton = (CorUIButton *)sender;
    brush = 5;
    isEraser = NO;
    
    switch(PressedButton.tag)
    {
        case 0:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            [self selectCorButton];
            PressedButton.layer.borderColor = [[UIColor  yellowColor] CGColor];
            break;
        case 1:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 255.0/255.0;
            [self selectCorButton];
            PressedButton.layer.borderColor = [[UIColor  yellowColor] CGColor];
            break;
        case 2:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            [self selectCorButton];
            PressedButton.layer.borderColor = [[UIColor  yellowColor] CGColor];
            break;
        case 3:
            red = 0.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            [self selectCorButton];
            PressedButton.layer.borderColor = [[UIColor  yellowColor] CGColor];
            break;
        case 4:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            [self selectCorButton];
            PressedButton.layer.borderColor = [[UIColor  yellowColor] CGColor];
            break;
    }
}

- (IBAction)erasePressed:(id)sender{
    isEraser = YES;
    
//    red = backGroundRed;
//    green = backGroundGreen;
//    blue = backGroundBlue;
    brush = 20;
//    opacity = 1;
}

- (IBAction)nextPage:(id)sender {
    
    
    //retira as imagens e textos da tela
    for (UIImageView *image in self.arrayImages) {
        [image removeFromSuperview];
    }
    for (UITextField *text in self.arrayTexts) {
        [text removeFromSuperview];
    }
    indexImage = 0;
    //currentImage.image = [self.tempImageView.image copy];
    //se a página é a última
    if (maxPageIndex == currentPageIndex) {
        
        if ([self.arrayPages count]-1 != currentPageIndex) {
            //salva as infomações da página em uma lista
            UIImage *drawImageView = self.tempImageView.image;
            NSMutableArray *arrayImage = self.arrayImages;
            NSMutableArray *arrayText = self.arrayTexts;
            
            Page *page = [[Page alloc]initWithElements :drawImageView :arrayImage :arrayText];
            
            [self.arrayPages addObject:page];
        }
//        //salva as infomações da página em uma lista
//        UIImage *drawImageView = self.tempImageView.image;
//        NSMutableArray *arrayImage = self.arrayImages;
//        NSMutableArray *arrayText = self.arrayTexts;
//        
//        Page *page = [[Page alloc]initWithElements :drawImageView :arrayImage :arrayText];
//        
//        [self.arrayPages addObject:page];
        
        
        //reseta as imagens e textos
        //self.arrayImages = nil;
        self.arrayImages = [[NSMutableArray alloc]init];
        //self.arrayTexts = nil;
        self.arrayTexts = [[NSMutableArray alloc]init];
        
        
        //aumenta o numero de paginas total e avanca uma pagina
        maxPageIndex += 1;
        currentPageIndex +=1;
        
        //currentImage.image = [self.tempImageView.image copy];
        //CGRect rect = self.tempImageView.frame;
        //apaga o desenho
        self.tempImageView.image = [[UIImage alloc] init] ;
        
    }
    
    //se a pagina atual não é a ultima
    else {
        
        
        //substitui as infomações da página atual na lista
        UIImage *drawImageView = self.tempImageView.image;
        NSMutableArray *arrayImage = self.arrayImages;
        NSMutableArray *arrayText = self.arrayTexts;
        
        Page *page = [[Page alloc]initWithElements :drawImageView :arrayImage :arrayText];
        
        [self.arrayPages replaceObjectAtIndex:currentPageIndex withObject:page];

        
        //apaga a tela de desenho
        //self.tempImageView.image = nil;
        self.tempImageView.image = [[UIImage alloc] init];
        //resgata a pagina posterior
        currentPageIndex +=1;
        
        Page *nextPage = [self.arrayPages objectAtIndex:currentPageIndex];
        
        self.tempImageView.image = [nextPage drawView];
        self.arrayImages = [nextPage arrayImage];
        self.arrayTexts = [nextPage arrayText];
        
        
        //adiciona imagens e textos
        for (UIImageView *image in self.arrayImages) {
            [self.view addSubview:image];
            [image sendSubviewToBack:self.view];
        }
        
        for (UITextField *text in self.arrayTexts) {
            [self.view addSubview:text];
            
        }
    }
    
    self.pageNumberLabel.text = [NSString stringWithFormat:@"%d", currentPageIndex];
}

- (IBAction)previewsPage:(id)sender {
    
    if (currentPageIndex >= 1) {
        
        //Salva a infomação da tela
        UIImage *drawImageView = self.tempImageView.image;
        NSMutableArray *arrayImage = self.arrayImages;
        NSMutableArray *arrayText = self.arrayTexts;
        
        Page *newPage = [[Page alloc]initWithElements :drawImageView :arrayImage :arrayText];
        
        
        if ([self.arrayPages count]-1 >= currentPageIndex)
        {
            [self.arrayPages replaceObjectAtIndex:currentPageIndex withObject:newPage];
        }
        else
        {
            [self.arrayPages addObject:newPage];
        }
        
        //esvazia a página atual
        for (UIImageView *image in self.arrayImages) {
            [image removeFromSuperview];
        }
        for (UITextField *text in self.arrayTexts) {
            [text removeFromSuperview];
        }
        
       // [self.arrayImages removeAllObjects];
        //[self.arrayTexts removeAllObjects];
        indexImage = 0;
        //self.tempImageView.image = nil;

        
        //preenche a pagina com a informaçao anterior
        currentPageIndex -= 1;
        Page *currentPage = [self.arrayPages objectAtIndex:currentPageIndex];
        
        self.tempImageView.image = [currentPage drawView];
        self.arrayImages = [currentPage arrayImage];
        self.arrayTexts = [currentPage arrayText];
        
        for (UIImageView *image in self.arrayImages) {
            [self.view addSubview:image];
            [image sendSubviewToBack:self.view];
        }
        
        for (UITextField *text in self.arrayTexts) {
            [self.view addSubview:text];
        }

    }
    self.pageNumberLabel.text = [NSString stringWithFormat:@"%d",currentPageIndex];
}


//metodos para forçar em landscape mode
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationMaskLandscapeLeft);
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (NSUInteger) application:(UIApplication *)application     supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationLandscapeLeft;
}

- (void) selectCorButton
{
    [_cor1UIButton initialise];
    [_cor2UIButton initialise];
    [_cor3UIButton initialise];
    [_cor4UIButton initialise];
    [_cor5UIButton initialise];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    mouseSwiped = NO;
    if(!isImageEditing){
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.mainImageView];


    if (!isScreenTouched) {
        self.lastTouch = [event timestamp];
    }
    else{
        self.lastTouch =[event timestamp]-totalInterval;
    }

    
    isScreenTouched = YES;
    NSLog(@"point %f %f", lastPoint.x, lastPoint.y);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = YES;
    
    if(!isImageEditing){
        
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.mainImageView];
    
    //NSLog(@"cuurent point %f %f", currentPoint.x, currentPoint.y);
        
    
    UIGraphicsBeginImageContext(self.mainImageView.frame.size);
    [self.tempImageView.image drawInRect:CGRectMake(0, 0, self.mainImageView.frame.size.width, self.mainImageView.frame.size.height)];
        
        
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    
        if (isEraser) {
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
        }
        else{
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
        }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempImageView setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    NSTimeInterval interval = [event timestamp] - self.lastTouch;
        VideoParameter *parameter;
        if (isEraser) {
            parameter = [[VideoParameter alloc] initWithParameter:lastPoint :currentPoint :interval :0 :-1 : -1: -1: 20];
        }
        else{
            parameter = [[VideoParameter alloc] initWithParameter:lastPoint :currentPoint :interval :0 :red : green: blue : 5];
        }
    
    [self.arrayPoints addObject:parameter];
    
    lastPoint = currentPoint;
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!isImageEditing){
        
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.mainImageView];
    
    totalInterval = [event timestamp]-self.lastTouch;
    
    lastPoint = currentPoint;
    }
}


//metodos para tirar snapshots da tela
- (IBAction)takeSnapshot:(id)sender
{
    UIImage *snapShot = [self snapshot:self.view];
    [self.arraySnapshots addObject:snapShot];
    
    backGroundRed = 145.0/255.0;
    backGroundGreen = 0.0/255.0;
    backGroundBlue = 255.0/255.0;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:backGroundRed green:backGroundGreen blue:backGroundBlue alpha:1]];
}



- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//métodos para gravar o audio e reproduzí-los
- (IBAction)gravarAudio:(id)sender {
    
    if(player.playing) {
        [player stop];
    }
    
    if(!recorder.recording){
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [recorder record];
        //[recordPauseButton setTitle:@"Pause" forStateUIControlStateNormal];
    }
//    else {
//        
//        // Pause recording
//        [recorder pause];
//        [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
//    }
    
    [self.pauseRecAudio setEnabled:YES];
    [self.pauseRecAudio setHidden:NO];
    [self.recAudio setEnabled:NO];
    [self.recAudio setHidden:YES];
}
- (IBAction)stopAudioRecorder:(id)sender {
    
    [recorder stop];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}
- (IBAction)playAudio:(id)sender {
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
    }
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    //[recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    
    [self.pauseRecAudio setEnabled:NO];
    [self.recAudio setEnabled:YES];
    [self.pauseRecAudio setHidden:YES];
    [self.recAudio setHidden:NO];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"
                                                    message: @"Finish playing the recording!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

//método chamado quando o vídeo precisa desenhar na tela
- (void)draw : (VideoParameter *)parameter
{
    UIGraphicsBeginImageContext(self.mainImageView.frame.size);
    [self.tempImageView.image drawInRect:CGRectMake(0, 0, self.mainImageView.frame.size.width, self.mainImageView.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), [parameter initialPoint].x, [parameter initialPoint].y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), [parameter finalPoint].x, [parameter finalPoint].y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), [parameter currentBrush] );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), [parameter currentRed], [parameter currentGreen], [parameter currentBlue], 1.0);
    
    if ([parameter currentRed] == -1 && [parameter currentGreen] == -1 &&[parameter currentBlue] == -1) {
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeClear);
    }
    else{
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    }
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempImageView setAlpha:opacity];
    UIGraphicsEndImageContext();


}

#pragma mark - AddImageMethods

- (IBAction)addImage:(id)sender {
    
    UIImagePickerController *pickerLibrary = [[ImagePickerLandscapeController alloc]init];
    pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerLibrary.delegate = self;
    [self presentViewController:pickerLibrary animated:YES completion:nil];
    
}
-(void)resizingImage:(UIPinchGestureRecognizer *)recognizer
{
    static CGRect initialBounds;
    
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        initialBounds = recognizer.view.bounds;
    }
    
    CGFloat factor = [(UIPinchGestureRecognizer *)recognizer scale];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, factor, factor);
    
    recognizer.view.bounds = CGRectApplyAffineTransform(initialBounds, transform);

}

-(void)moveImage: (UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint touchLocation = [recognizer locationInView:self.view];
        recognizer.view.center = touchLocation;
    }
}

-(void)rotateImage: (UIRotationGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged)
    {
        recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
        [recognizer setRotation:0];
    }
}

//Termina processo de edição de imagens fixando-a e colocando atrás da tela de desenho.
- (IBAction)confirmImageEdition:(id)sender {
    
    UIImageView *image = self.arrayImages[indexImage];
    
    [self.view sendSubviewToBack:image];
    image.userInteractionEnabled = NO;
    indexImage += 1;
    
    self.addImageButton.enabled = YES;
    self.addImageButton.hidden = NO;
    self.confirmImageButton.enabled = NO;
    self.confirmImageButton.hidden = YES;
    
    isImageEditing = NO;
    
}

#pragma mark - AddTextMethods

- (IBAction)addText:(id)sender {
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(self.tempImageView.frame.size.width/2, self.tempImageView.frame.size.height/2, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:50];
    textField.placeholder = @"enter text";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.delegate = self;
    
    self.currentTextField = textField;
    
    [self.view addSubview:textField];
}


#pragma mark - ImagePickerControllerDelegateMethod

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[self dismissViewControllerAnimated:NO completion:nil];
	UIImage *choseImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    UIImageView *customImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.tempImageView.frame.size.width/2, self.tempImageView.frame.size.height/2, 300, 300)];
    isImageEditing = YES;
    
    customImage.image = choseImage;
    customImage.contentMode = UIViewContentModeScaleAspectFill;
    customImage.userInteractionEnabled = YES;
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(resizingImage:)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveImage:)];
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateImage:)];
    
    [customImage addGestureRecognizer:pinchGesture];
    [customImage addGestureRecognizer:panGesture];
    [customImage addGestureRecognizer:rotationGesture];
    
    [self.arrayImages addObject:customImage];
    
    [self.view addSubview:customImage];
    
    self.addImageButton.enabled = NO;
    self.addImageButton.hidden = YES;
    self.confirmImageButton.enabled = YES;
    self.confirmImageButton.hidden = NO;

}

#pragma mark - UItextFieldDelegateMethods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.currentTextField.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(resizingImage:)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveImage:)];
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateImage:)];
    
    [self.currentTextField addGestureRecognizer:pinchGesture];
    [self.currentTextField addGestureRecognizer:panGesture];
    [self.currentTextField addGestureRecognizer:rotationGesture];
    
    [self.currentTextField setBorderStyle:UITextBorderStyleNone];
    [self.currentTextField setNeedsDisplay];
    
    [self.arrayTexts addObject:self.currentTextField];
    
    self.currentTextField = nil;
    
    return YES;
}




@end
