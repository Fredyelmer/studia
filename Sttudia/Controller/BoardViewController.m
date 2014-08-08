//
//  BoardViewController.m
//  Sttudia
//
//  Created by Fredy Arias on 30/06/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "BoardViewController.h"

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
    UIWebView *webView;
    CGPoint centerImage;
    CGFloat lastScale;
    CGFloat lastRotation;
    int numEraserButtonTap;
    
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
    
    //inicializa o brush
    [self setBrushColor:[UIColor blackColor]];
    brush = 5.0;
    eraser = 20.0;
    opacity = 1.0;
    
    backGroundRed = 255.0/255.0;
    backGroundGreen = 255.0/255.0;
    backGroundBlue = 255.0/255.0;
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:backGroundRed green:backGroundGreen blue:backGroundBlue alpha:1]];
    [self selectedButton:[self.ColorButton objectAtIndex:0 ]];
    
    self.arraySnapshots = [[NSMutableArray alloc]init];
    self.arrayPoints = [[NSMutableArray alloc]init];
    self.isRecording = NO;
    
    [self.recAudio setEnabled:YES];
    [self.pauseRecAudio setHidden:YES];
    [self.pauseRecAudio setEnabled:YES];
    
    //long press gesture
    [self.layoutView setHidden:YES];
    
    // self.squarePicker up
    
    UILongPressGestureRecognizer *longPressGesture1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedButton:)];
    UILongPressGestureRecognizer *longPressGesture2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedButton:)];
    UILongPressGestureRecognizer *longPressGesture3 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedButton:)];
    UILongPressGestureRecognizer *longPressGesture4 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedButton:)];
    UILongPressGestureRecognizer *longPressGesture5 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedButton:)];
    [[self.ColorButton objectAtIndex:0] addGestureRecognizer:longPressGesture1];
    [[self.ColorButton objectAtIndex:1] addGestureRecognizer:longPressGesture2];
    [[self.ColorButton objectAtIndex:2] addGestureRecognizer:longPressGesture3];
    [[self.ColorButton objectAtIndex:3] addGestureRecognizer:longPressGesture4];
    [[self.ColorButton objectAtIndex:4] addGestureRecognizer:longPressGesture5];
    
    [self updateThicknessButton];
    
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
    self.arrayUndo = [[NSMutableArray alloc]init];
    self.arrayRedo = [[NSMutableArray alloc]init];
    
    self.addImageButton.enabled = YES;
    self.addImageButton.hidden = NO;
    self.confirmImageButton.enabled = NO;
    self.confirmImageButton.hidden = YES;
    
    finishTextEdit = YES;
    
    maxPageIndex = 0;
    currentPageIndex = 0;
    
    self.pageNumberLabel.text = [NSString stringWithFormat:@"%d/%d", currentPageIndex+1, maxPageIndex+1];
    
    self.undoButton.enabled = NO;
    self.redoButton.enabled = NO;
    self.backButton.enabled = NO;
    [self.topBar bringSubviewToFront:self.view];
    [self.bottonBar bringSubviewToFront:self.view];
    
    undoMade = NO;
    numEraserButtonTap = 0;
}

- (void) setBrushColor:(UIColor *) color
{
    [color getRed:&red green:&green blue:&blue alpha:&opacity];
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
    
    if (!recorder.recording){
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player play];
    }
    
    for (int i = 0; i < [self.arrayPoints count]; i++) {
        
        VideoParameter *parameter = self.arrayPoints[i];
        if ([parameter isDrawing]){
            [self performSelector:@selector(draw:) withObject:parameter afterDelay:[parameter interval]];
        }
//        else if ([self.arrayPoints[i] imageAdded]){
//            while (![self.arrayPoints[i] isTaskTerminated]) {
//                NSLog(@"não terminado");
//                if ([self.arrayPoints[i-1] isTaskTerminated]) {
//                    
//                     NSLog(@"terminado");
//                    [self.view addSubview:[self.arrayPoints[i] imageView]];
//                    [self.view sendSubviewToBack:[self.arrayPoints[i] imageView]];
//                }
//            }
//        }
//        else if ([parameter pageChanged]){
//            if ([parameter isForward]) {
//                if ([parameter pageNumber] == [parameter maxPageNumber]) {
//                    self.tempImageView.image = nil;
//                }
//                else{
//                    
//                }
//            }
//        }
    }
}

-(void)chamada{
    
    UIImage *image = [self snapshot:self.tempImageView];
    [self.arraySnapshots addObject:image];
    NSLog(@"tirou foto");
}

- (void) longPressedButton:(UIGestureRecognizer *)gesture
{
    if (gesture.state==UIGestureRecognizerStateBegan)
    {
        NSLog(@"long press: %ld",(long)[gesture.view tag]);
//        selectedButton = [gesture.view tag];
//        
//        _sourceColor = [[_ColorButton objectAtIndex:selectedButton] backgroundColor];
//        _sourceColorButton.backgroundColor = _sourceColor;
//        _resultColorButton.backgroundColor = _sourceColor;
//        [self.colorPicker setHidden:NO];
    }
}

- (IBAction)erasePressed:(CorUIButton*)sender{

    if (numEraserButtonTap == 0) {
        isEraser = YES;
        [self selectedButton:sender];
        numEraserButtonTap += 1;
        [self updateThicknessButton];
    }
    else {
        ResetViewController *resetVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"resetVC"];
        
        resetVC. delegate = self;
        
        self.popoverAddImage = [[UIPopoverController alloc] initWithContentViewController:resetVC];
        [self.popoverAddImage presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

        numEraserButtonTap = 0;
    }
}

- (IBAction)nextPage:(id)sender {
    
    //método para tirar printscreen
    //[self takePrintScreen];
    
    //retira as imagens e textos da tela
    for (UIImageView *image in self.arrayImages) {
        [image removeFromSuperview];
    }
    for (UITextField *text in self.arrayTexts) {
        [text removeFromSuperview];
    }
    indexImage = 0;
    
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
        
        //reseta as imagens e textos
        self.arrayImages = [[NSMutableArray alloc]init];
        self.arrayTexts = [[NSMutableArray alloc]init];
        
        
        //aumenta o numero de paginas total e avanca uma pagina
        maxPageIndex += 1;
        currentPageIndex +=1;
        
        //apaga o desenho
        self.tempImageView.image = [[UIImage alloc] init] ;
        
        [UIView transitionWithView:self.view
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            /* any other animation you want */
                        } completion:^(BOOL finished) {
                            /* hide/show the required cells*/
                        }];
        
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
            [self.view sendSubviewToBack:image];
            [self.view sendSubviewToBack:self.layoutImageView];
        }
        
        for (UITextField *text in self.arrayTexts) {
            [self.view addSubview:text];
            
        }
        
        [UIView transitionWithView:self.view
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            /* any other animation you want */
                        } completion:^(BOOL finished) {
                            /* hide/show the required cells*/
                        }];

    }
    
    self.pageNumberLabel.text = [NSString stringWithFormat:@"%d/%d", currentPageIndex+1, maxPageIndex+1];
    VideoParameter *parameter = [[VideoParameter alloc]initWithNumberOfPage:currentPageIndex :maxPageIndex :YES];
    
    [self.arrayPoints addObject:parameter];
    
    self.backButton.enabled = YES;

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
        
        indexImage = 0;
        
        
        currentPageIndex -= 1;
        
        //desabilita o botão de voltar
        if (currentPageIndex == 0) {
            self.backButton.enabled = NO;
        }
        //preenche a pagina com a informaçao anterior
        Page *currentPage = [self.arrayPages objectAtIndex:currentPageIndex];
        
        self.tempImageView.image = [currentPage drawView];
        self.arrayImages = [currentPage arrayImage];
        self.arrayTexts = [currentPage arrayText];
        
        for (UIImageView *image in self.arrayImages) {
            [self.view addSubview:image];
            [self.view sendSubviewToBack:image];
        }
        
        for (UITextField *text in self.arrayTexts) {
            [self.view addSubview:text];
        }
        [UIView transitionWithView:self.view
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            /* any other animation you want */
                        } completion:^(BOOL finished) {
                            /* hide/show the required cells*/
                        }];

    }
    self.pageNumberLabel.text = [NSString stringWithFormat:@"%d/%d", currentPageIndex+1, maxPageIndex+1];
    
    VideoParameter *parameter = [[VideoParameter alloc]initWithNumberOfPage:currentPageIndex :maxPageIndex :NO];
    
    [self.arrayPoints addObject:parameter];
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

- (NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationLandscapeLeft;
}

//inisializ e marca o botao seleccionado
- (void) selectedButton:(CorUIButton*) button
{
    for (CorUIButton *colorButton in self.ColorButton)
    {
        [colorButton initialise];
        [colorButton setState:NO];
    }
    //inicialisa botao borracha
    _eraseButton.layer.borderColor = [[UIColor  lightGrayColor] CGColor];
    _eraseButton.state = NO;
    
    button.layer.borderColor = [[UIColor yellowColor] CGColor];
    button.state = YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
    if(!isImageEditing)
    {
        UITouch *touch = [touches anyObject];
        lastPoint = [touch locationInView:self.mainImageView];


        if (!isScreenTouched)
        {
            self.lastTouch = [event timestamp];
        }
        else
        {
            self.lastTouch =[event timestamp]-totalInterval;
        }

    
        isScreenTouched = YES;
        NSLog(@"point %f %f", lastPoint.x, lastPoint.y);
        //[[self.ColorButton objectAtIndex:selectedButton] setState:NO];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = YES;
    
    if(!isImageEditing){
        
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.mainImageView];
    
    UIGraphicsBeginImageContext(self.mainImageView.frame.size);
    [self.tempImageView.image drawInRect:CGRectMake(0, 0, self.mainImageView.frame.size.width, self.mainImageView.frame.size.height)];
        
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    
        if (isEraser) {
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), eraser );
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
            
        }
        else{
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
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
        
        UIImage *newImage = self.tempImageView.image;
        
        if (self.tempImageView.image) {
            [self.arrayUndo addObject:newImage];
            self.undoButton.enabled = YES;
        }
        if (undoMade) {
            self.arrayRedo = [[NSMutableArray alloc]init];
            self.redoButton.enabled = NO;
        }
    }
}


//metodos para tirar snapshots da tela
- (IBAction)takeSnapshot:(id)sender
{
    UIImage *snapShot = [self snapshot:self.tempImageView];
    [self.arraySnapshots addObject:snapShot];

}

- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)takePrintScreen
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    UIImage *printScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.arraySnapshots addObject:printScreen];

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
    
    [parameter setIsTaskTerminated: YES];
    NSLog(@"Terminou task");
    
}

#pragma mark - AddImageMethods

- (IBAction)addImage:(id)sender {
    
    
    AddImageViewController *addImageViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddImageVC"];
    
    addImageViewController.delegate = self;
    
    self.popoverAddImage = [[UIPopoverController alloc] initWithContentViewController:addImageViewController];
    [self.popoverAddImage presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)addImageFromLibrary
{
    NSLog(@"delele");
    UIImagePickerController *pickerLibrary = [[ImagePickerLandscapeController alloc]init];
    pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerLibrary.delegate = self;
    [self presentViewController:pickerLibrary animated:YES completion:nil];
    [self.popoverAddImage dismissPopoverAnimated:YES];
    
}

- (void)addPhoto
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
    [self.popoverAddImage dismissPopoverAnimated:YES];
    
    
}

- (void)getPhotoFromInternet
{
    CollectionViewController *collectionVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"collectionVC"];
    
    collectionVC.delegate = self;
    
    //[self performSegueWithIdentifier:@"collectionView" sender:nil];
    [self presentViewController:collectionVC animated:YES completion:nil];
    [self.popoverAddImage dismissPopoverAnimated:YES];
}

-(void)resizingImage:(UIPinchGestureRecognizer *)recognizer
{
    [self.view bringSubviewToFront:recognizer.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - recognizer.scale);
    
    
    CGAffineTransform currentTransform = recognizer.view.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [recognizer.view setTransform:newTransform];
    
    lastScale = recognizer.scale;
}


-(void)moveImage: (UIPanGestureRecognizer *)recognizer
{
    
    [[[recognizer view] layer] removeAllAnimations];
    //[self.view bringSubviewToFront:[recognizer view]];
    CGPoint translatedPoint = [recognizer translationInView:self.view];
    
    if([recognizer state] == UIGestureRecognizerStateBegan) {
		
		centerImage.x = [[recognizer view] center].x;
		centerImage.y = [[recognizer view] center].y;
	}
    
    translatedPoint = CGPointMake(centerImage.x+translatedPoint.x, centerImage.y+translatedPoint.y);
	
	[[recognizer view] setCenter:translatedPoint];
    
    if([recognizer state] == UIGestureRecognizerStateEnded) {
		
		CGFloat finalX = translatedPoint.x + (.35*[recognizer velocityInView:self.view].x);
		CGFloat finalY = translatedPoint.y + (.35*[recognizer velocityInView:self.view].y);
		
		if(UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
			
			if(finalX < 0) {
				
				finalX = 0;
			}
			
			else if(finalX > 768) {
				
				finalX = 768;
			}
			
			if(finalY < 0) {
				
				finalY = 0;
			}
			
			else if(finalY > 1024) {
				
				finalY = 1024;
			}
		}
		
		else {
			
			if(finalX < 0) {
				
				finalX = 0;
			}
			
			else if(finalX > 1024) {
				
				finalX = 1024;
			}
			
			if(finalY < 0) {
				
				finalY = 0;
			}
			
			else if(finalY > 768) {
				
				finalY = 768;
			}
		}
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.35];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[[recognizer view] setCenter:CGPointMake(finalX, finalY)];
		[UIView commitAnimations];
	}


}

-(void)rotateImage: (UIRotationGestureRecognizer *)recognizer
{
    if([recognizer state] == UIGestureRecognizerStateEnded) {
		
		lastRotation = 0.0;
		return;
	}
	
	CGFloat rotation = 0.0 - (lastRotation - [recognizer rotation]);
	
	CGAffineTransform currentTransform = [recognizer view].transform;
	CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
	
	[[recognizer view] setTransform:newTransform];
	
	lastRotation = [recognizer rotation];
}

//Termina processo de edição de imagens fixando-a e colocando atrás da tela de desenho.
- (IBAction)confirmImageEdition:(id)sender {
    
    UIImageView *image = self.arrayImages[indexImage];
    
    [self.view sendSubviewToBack:image];
    //[self.tempImageView addSubview:image];
    [self.view sendSubviewToBack:self.layoutImageView];
    image.userInteractionEnabled = NO;
    indexImage += 1;
    
    self.addImageButton.enabled = YES;
    self.addImageButton.hidden = NO;
    self.confirmImageButton.enabled = NO;
    self.confirmImageButton.hidden = YES;
    
    
    isImageEditing = NO;
    
    //VideoParameter *parameter = [[VideoParameter alloc]initWithImage:image];
    //[self.arrayPoints addObject:parameter];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	
	return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark - ImagePickerControllerDelegateMethod

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
    [self dismissViewControllerAnimated:YES completion:nil];
	UIImage *choseImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self putImageInScreen:choseImage];
    
}

- (void) putImageInScreen : (UIImage *)image
{
    UIImageView *customImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.tempImageView.frame.size.width/2-150, self.tempImageView.frame.size.height/2-150, 300, 300)];
    customImage.image = image;
    customImage.contentMode = UIViewContentModeScaleAspectFill;
    
    
    isImageEditing = YES;
    
    customImage.userInteractionEnabled = YES;
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(resizingImage:)];
    pinchGesture.delegate = self;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveImage:)];
    panGesture.delegate = self;
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateImage:)];
    rotationGesture.delegate = self;
    
    [customImage addGestureRecognizer:pinchGesture];
    [customImage addGestureRecognizer:panGesture];
    [customImage addGestureRecognizer:rotationGesture];
    
    [self.arrayImages addObject:customImage];
    
    [self.view addSubview:customImage];
    
    [self.topBar bringSubviewToFront:self.view];
    [self.bottonBar bringSubviewToFront:self.view];
    
    
    self.addImageButton.enabled = NO;
    self.addImageButton.hidden = YES;
    self.confirmImageButton.enabled = YES;
    self.confirmImageButton.hidden = NO;

}

#pragma mark - ColorMethods
- (IBAction)ColorPressed:(CorUIButton *)sender
{
    isEraser = NO;
    if (sender.state)
    {
        //ativa acao de cor customizado
        [self initPickerColor:sender];
    }
    else
    {
        [self selectedButton:sender];
        //ativa o cor que vai se usar
        [self setBrushColor:sender.backgroundColor];
        [self updateThicknessButton];
    }
}

- (IBAction)changeThickness:(id)sender
{
    ThicknessViewController *thicknessViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"Thickness"];
    
    thicknessViewController.delegate = self;
    
    for (CorUIButton *button in self.ColorButton)
    {
        if (button.state)
        {
            thicknessViewController.color = button.backgroundColor;
        }
    }
    
    if (isEraser) {
        thicknessViewController.brush = eraser;
        thicknessViewController.color = [UIColor blackColor];
    }
    else
    {
        thicknessViewController.brush = brush;
    }
    
    self.popoverThickness = [[UIPopoverController alloc] initWithContentViewController:thicknessViewController];
    [self.popoverThickness presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [self updateThicknessButton];
}

//inisializa e mostra o menu de cores customizados
- (void) initPickerColor:(CorUIButton *) sender
{
    UIColor *color = sender.backgroundColor;
    ColorPickerViewController *colorPickerViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ColorPickerPopover"];
    
    colorPickerViewController.color = color;
    colorPickerViewController.delegate = self;
    
    self.popoverColorPicker = [[UIPopoverController alloc] initWithContentViewController:colorPickerViewController];
    [self.popoverColorPicker presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - AddTextMethods

- (IBAction)addText:(id)sender {
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(self.tempImageView.frame.size.width/2 - 50, self.tempImageView.frame.size.height/2 + 15, 100, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:20];
    textField.placeholder = @"enter text";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textAlignment = NSTextAlignmentLeft;
    //[textField invalidateIntrinsicContentSize];
    textField.delegate = self;
    
    self.currentTextField = textField;
    //[self.currentTextField invalidateIntrinsicContentSize];
    
    [self.view addSubview:textField];
}

#pragma mark - UItextFieldDelegateMethods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [UIView animateWithDuration:0.1 animations:^{
        [textField sizeToFit];
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.currentTextField.userInteractionEnabled = YES;
    //textField.userInteractionEnabled = YES;

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
    NSLog(@"teclado");
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)setBackgroundView:(id)sender
{
    [self.layoutView setHidden:NO];
}


- (IBAction)changeLayout:(UIButton *)sender
{
    NSLog(@"button %@", sender.titleLabel.text);
    UIImage *image;
    
    if ([sender.titleLabel.text  isEqual: @"branco"]) {
        image = [[UIImage alloc] init];
    }
    if ([sender.titleLabel.text  isEqual: @"quadrado"]) {
        image = [UIImage imageNamed:@"quadrado.jpg"];
    }
    if ([sender.titleLabel.text  isEqual: @"forrado"]) {
        image = [UIImage imageNamed:@"forrado.png"];
    }
    if ([sender.titleLabel.text  isEqual: @"agenda"]) {
        image = [UIImage imageNamed:@"agenda.png"];
    }
    [self.layoutImageView setImage:image];
    [self.view sendSubviewToBack:self.layoutImageView];
    [self.layoutView setHidden:YES];
}

-(void)newColorBrush:(UIColor *)newColor
{
    for (CorUIButton *button in self.ColorButton)
    {
        if (button.state)
        {
            button.backgroundColor = newColor;
        }
    }
    [self setBrushColor:newColor];
}

-(void)dismissColorPicker
{
    [self.popoverColorPicker dismissPopoverAnimated:YES];
}

#pragma mark - UNDO/REDO Methods

- (IBAction)undo:(id)sender {
    
    UIImage *image = [self.arrayUndo lastObject];
    
    if (image) {
        [self.arrayRedo addObject:image];
        [self.arrayUndo removeLastObject];
        self.tempImageView.image = [self.arrayUndo lastObject];
        undoMade = YES;
        
    }
    
    if ([self.arrayUndo count] == 0) {
        self.undoButton.enabled = NO;
    }
    
    self.redoButton.enabled = YES;
    
    NSLog(@"undo");
}

- (IBAction)redo:(id)sender {
    
    UIImage *image = [self.arrayRedo lastObject];
    
    if (image) {
        [self.arrayUndo addObject:image];
        [self.arrayRedo removeLastObject];
        self.tempImageView.image = image;
        
    }
    
    if ([self.arrayRedo count] == 0) {
        self.redoButton.enabled = NO;
    }
    self.undoButton.enabled = YES;

}

#pragma mark - CollectionViewControllerDelegateMethod

- (void)setInternetImageChose : (UIImage *)image{
    
    [self putImageInScreen:image];
}

#pragma mark - ResetViewControllerDelegateMethods
- (void) resetTint
{
    self.tempImageView.image = nil;
}

- (void) resetAll
{
    for (UIImageView* imageView in self.arrayImages) {
        [imageView removeFromSuperview];
    }
    for (UITextField* textField in self.arrayTexts) {
        [textField removeFromSuperview];
    }
    [self resetTint];
    self.arrayImages = [[NSMutableArray alloc]init];
    self.arrayTexts = [[NSMutableArray alloc]init];
}

-(void)newThicknessBrush:(CGFloat)thickness
{
    if (isEraser) {
        eraser = thickness;
    }
    else
    {
        brush = thickness;
    }
    
    [self updateThicknessButton];
}

-(void) updateThicknessButton
{
    UIGraphicsBeginImageContext(self.thicknessButton.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    
    if (isEraser) {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(),eraser/2);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
    }
    else
    {
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(),brush/2);
        
    }
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 22, 22);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 22, 22);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.thicknessButton.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
@end
