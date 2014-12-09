//
//  ClassesViewController.m
//  Sttudia
//
//  Created by Helder Lima da Rocha on 7/3/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "ClassesViewController.h"

@interface ClassesViewController ()

@end

@implementation ClassesViewController


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        PFUser *user = [PFUser currentUser];
        if (user) {
            PFQuery *classRepositoryQuery = [PFQuery queryWithClassName:@"ClassRepository"];
            [classRepositoryQuery whereKey:@"owner" equalTo:user];
            
            [classRepositoryQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
                if (!error) {
                    self.classRepository = object;
                    PFQuery *classesQuery = [PFQuery queryWithClassName:@"Class"];
                    [classesQuery whereKey:@"classRepository" equalTo:object];
                    
//                    self.classArray = [classesQuery findObjects];
//                    [self.collectionView reloadData];
                                    [classesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                                        if (!error) {
                                            self.classArray = objects;
                                            [self.collectionView reloadData];
                                        }
                                    }];
                    
                }
                
                
            }];
            
            
//            PFObject *object = [classRepositoryQuery getFirstObject];
//            PFQuery *classesQuery = [PFQuery queryWithClassName:@"Class"];
//            [classesQuery whereKey:@"classRepository" equalTo:object];
//            
//            self.classArray = [classesQuery findObjects];
//            [self.collectionView reloadData];

            
        }
        
        else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Acesso negado!" message:@"Voce precisa estar logado para visualizar as suas aulas!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [message show];
        
        }

    }
    
    return self;
}
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
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"%d", [self.classArray count]);
    return [self.classArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassesCollectionViewCell  *cCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"classcell" forIndexPath:indexPath];
    PFObject *classObject = [self.classArray objectAtIndex:indexPath.row];
        
    cCell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
//    PFObject *screenShotObject = [classObject objectForKey:@"image"];
    PFFile *imageFile = [classObject objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // Now that the data is fetched, update the cell's image property.
        cCell.imageView.image = [UIImage imageWithData:data];
        
    }];
    
    cCell.author.text = [classObject objectForKey:@"author"];
    cCell.name.text = [classObject objectForKey:@"name"];
    

    
    return cCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [collectionView  cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    
    self.objectClass = [self.classArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"loadClass" sender:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView  cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}
- (IBAction)newClass:(id)sender {
    
    AddNewClassViewController *newClassVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"newClass"];
    newClassVC.delegate = self;
    
    
    self.popoverNewClass = [[UIPopoverController alloc] initWithContentViewController:newClassVC];
    [self.popoverNewClass presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.popoverNewClass.delegate = self;

}

- (IBAction)performSearch:(id)sender {
    NSString *searchParameterlowercase = [self.searchBar.text lowercaseString];
    
    PFQuery *searchQuery = [PFQuery queryWithClassName:@"Class"];
    
    [searchQuery whereKey:@"searchName" equalTo:searchParameterlowercase];
    [searchQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            self.classArray = objects;
            [self.collectionView reloadData];
        }
    }];

    
}

- (void) createNewClass:(NSString *)nameClass {
    PFUser *user = [PFUser currentUser];
    
    if (user) {
        
        
        PFObject *newClass = [PFObject objectWithClassName:@"Class"];
        PFObject *newQuestionsRepository = [PFObject objectWithClassName:@"QuestionsRepository"];
        
        [newQuestionsRepository setValue:nameClass forKey:@"aula"];
        [newQuestionsRepository setValue:newClass forKey:@"class"];
        [newQuestionsRepository setValue:user.username forKey:@"repositoryMaster"];
        
        [newClass setValue:self.classRepository forKey:@"classRepository"];
        [newClass setValue:user.username forKey:@"author"];
        [newClass setValue:nameClass forKey:@"name"];
        [newClass setValue:[nameClass lowercaseString] forKey:@"searchName"];
        
//        NSMutableArray *arrayImages = [[NSMutableArray alloc]init];
//        [newClass setObject:arrayImages forKey:@"imageArray"];
//        PFACL *acl = [PFACL ACL];
//        
//        [acl setPublicReadAccess:YES];
//        [acl setPublicWriteAccess:YES];
//        
//        [newClass setObject:acl forKey:@"ACL"];

        [newClass saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (!error) {
                
                [newQuestionsRepository saveInBackgroundWithBlock:^(BOOL succedded, NSError *error2){
                    if (!error2) {
                        PFQuery *newQuestionsRepositoryQuery = [PFQuery queryWithClassName:@"QuestionsRepository"];
                        [newQuestionsRepositoryQuery whereKey:@"class" equalTo:newClass];
                        
                        [newQuestionsRepositoryQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *errorRep){
                            if (!errorRep) {
                                PFObject *aQuestion = [PFObject objectWithClassName:@"AnsweredQuestions"];
                                PFObject *uQuestion = [PFObject objectWithClassName:@"UnansweredQuestions"];
                                NSLog(@"%@", object.objectId);
                                [aQuestion setValue:object forKey:@"repository"];
                                [uQuestion setValue:object forKey:@"repository"];
                                
                                [aQuestion saveInBackgroundWithBlock:^(BOOL seccedded, NSError * error3){
                                    if (!error3) {
                                        
                                        [uQuestion saveInBackgroundWithBlock:^(BOOL seccedded, NSError * error4){
                                            if (!error4) {
                                                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Parabens!" message:@"Voce criou uma aula!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                [message show];
                                                message.tag = 100;
                                                self.objectClass = newClass;
                                            }
                                        }];
                                    }
                                }];
                            }
                        }];
                    }
                }];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha na criação da aula" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

            }
        
        }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Acesso negado" message:@"Você precisa estar logado para criar uma aula" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            [self.popoverNewClass dismissPopoverAnimated:YES];
            [self performSegueWithIdentifier:@"newClassSegue" sender:nil];
        }
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    
    NSString *searchParameterlowercase = [self.searchBar.text lowercaseString];
    [self.searchBar resignFirstResponder];
    PFQuery *searchQuery = [PFQuery queryWithClassName:@"Class"];

    [searchQuery whereKey:@"searchName" equalTo:searchParameterlowercase];
    [searchQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            self.classArray = objects;
            [self.collectionView reloadData];
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newClassSegue"]) {
        BoardViewController *boardVC = [segue destinationViewController];
        
        [boardVC setObjectClass:self.objectClass];
    }
    else if([segue.identifier isEqualToString:@"loadClass"]){
        BoardViewController *boardVC = [segue destinationViewController];
        
        [boardVC setObjectClass:self.objectClass];
        [boardVC setIsVisualization:YES];
    }
}


@end
