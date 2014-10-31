//
//  ConnectionsViewController.h
//  Sttudia
//
//  Created by Fredy Arias on 28/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol ConnectionsViewControllerDelegate

-(void) stablishHost:(BOOL) isHost;

@end

@interface ConnectionsViewController : UIViewController <MCBrowserViewControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<ConnectionsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UISwitch *swVisible;
@property (strong, nonatomic) IBOutlet UISwitch *swHost;
@property (strong, nonatomic) IBOutlet UITableView *tblConnectedDevices;
@property (strong, nonatomic) IBOutlet UIButton *btnDisconnect;


- (IBAction)browseForDevices:(id)sender;
- (IBAction)toggleVisibility:(id)sender;
- (IBAction)disconnect:(id)sender;
- (IBAction)toggleHost:(id)sender;


@end
