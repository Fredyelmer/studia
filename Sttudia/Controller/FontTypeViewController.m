//
//  FontTypeViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 08/08/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "FontTypeViewController.h"

@interface FontTypeViewController ()
@property (strong, nonatomic) IBOutlet UITableView *fontTableView;

@end

@implementation FontTypeViewController

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
    
    self.fontRepository = [[NSArray alloc]initWithObjects:@"AlNile", @"AmericanTypewriter", @"AppleColorEmoji", @"AppleSDGothicNeo-Regular", @"ArialMT",@"ArialHebrew",@"Avenir-Book",@"Baskerville",@"ChalkboardSE-Regular",@"Chalkduster",@"Cochin",@"Copperplate",@"Courier",@"Damascus",@"Didot",@"Helvetica",@"HelveticaNeue",@"Marion-Regular",@"MarkerFelt-Thin",@"SavoyeLetPlain",@"SnellRoundhand",@"Symbol",@"TimesNewRomanPSMT",@"TrebuchetMS",@"Verdana",@"Zapfino",nil];
    self.fontTableView = [[UITableView alloc]init];
    self.fontTableView.delegate = self;
    self.fontTableView.dataSource = self;
    
    [self.fontTableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Fontes";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fontRepository count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self.fontRepository objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:[self.fontRepository objectAtIndex:indexPath.row] size:20];
    
    return cell;

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate setFontType:[self.fontRepository objectAtIndex:indexPath.row]];
}


@end
