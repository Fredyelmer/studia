//
//  ConnectionsViewController.m
//  Sttudia
//
//  Created by Fredy Arias on 28/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ConnectionsViewController.h"
#import "AppDelegate.h"

@interface ConnectionsViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification;

@end

@implementation ConnectionsViewController

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
    // Do any additional setup after loading the view.
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (self.appDelegate.mcManager.session == nil) {
        [[_appDelegate mcManager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
        [[_appDelegate mcManager] advertiseSelf:_swVisible.isOn];
    }
    else
    {
        _txtName.text = self.appDelegate.mcManager.session.myPeerID.displayName;
        [_btnDisconnect setEnabled:!YES];
        //[_txtName setEnabled:NO];
    }
    
    [_txtName setDelegate:self];
    [self.swHost setOn:self.isHost];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
    
    _arrConnectedDevices = [[NSMutableArray alloc] init];
    
    for (MCPeerID *peer in self.appDelegate.mcManager.session.connectedPeers) {
        [_arrConnectedDevices addObject:peer.displayName];
    }
    
    [_tblConnectedDevices setDelegate:self];
    [_tblConnectedDevices setDataSource:self];
    
    [_tblConnectedDevices reloadData];
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void)viewDidDisappear:(BOOL)animated
{
    //NSLog(@"teste");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)browseForDevices:(id)sender {
    if (self.appDelegate.mcManager.session != nil) {
        [[_appDelegate mcManager] setupMCBrowser];
        [[[_appDelegate mcManager] browser] setDelegate:self];
        [self presentViewController:[[_appDelegate mcManager] browser] animated:YES completion:nil];
    }
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (IBAction)toggleVisibility:(id)sender {
    [_appDelegate.mcManager advertiseSelf:_swVisible.isOn];
}

- (IBAction)disconnect:(id)sender {
    [_appDelegate.mcManager.session disconnect];
    
    _txtName.enabled = YES;
    
    [_arrConnectedDevices removeAllObjects];
    [_tblConnectedDevices reloadData];
}

- (IBAction)toggleHost:(id)sender {
    [self.delegate stablishHost:self.swHost.isOn];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma delegate
-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
     NSLog(@"%s", __PRETTY_FUNCTION__);
}


-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
     NSLog(@"%s", __PRETTY_FUNCTION__);
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_txtName resignFirstResponder];
    
    _appDelegate.mcManager.peerID = nil;
    _appDelegate.mcManager.session = nil;
    _appDelegate.mcManager.browser = nil;
    
    if ([_swVisible isOn]) {
        [_appDelegate.mcManager.advertiser stop];
    }
    _appDelegate.mcManager.advertiser = nil;
    
    
    [_appDelegate.mcManager setupPeerAndSessionWithDisplayName:_txtName.text];
    [_appDelegate.mcManager setupMCBrowser];
    [_appDelegate.mcManager advertiseSelf:_swVisible.isOn];
    
    return YES;
}

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification
{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    
//    if (state != MCSessionStateConnecting) {
//        if (state == MCSessionStateConnected) {
//            
//            [_arrConnectedDevices addObject:peerDisplayName];
//        }
//        else if (state == MCSessionStateNotConnected){
//            if ([_arrConnectedDevices count] > 0) {
//                int indexOfPeer = (int)[_arrConnectedDevices indexOfObject:peerDisplayName];
//                [_arrConnectedDevices removeObjectAtIndex:indexOfPeer];
//            }
//        }
//        
//        [_tblConnectedDevices reloadData];
//        
//        BOOL peersExist = ([[_appDelegate.mcManager.session connectedPeers] count] == 0);
//        [_btnDisconnect setEnabled:!peersExist];
//        [_txtName setEnabled:peersExist];
//    }
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrConnectedDevices count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    cell.textLabel.text = [_arrConnectedDevices objectAtIndex:indexPath.row];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

@end
