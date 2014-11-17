//
//  PageControllerManagerViewController.m
//  Sttudia
//
//  Created by Ricardo Nagaishi on 15/11/14.
//  Copyright (c) 2014 Ricardo Nagaishi. All rights reserved.
//

#import "PageControllerManagerViewController.h"

@interface PageControllerManagerViewController ()

@end

@implementation PageControllerManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageTitles = @[@"Bem vindo ao Sttudia", @"Tuto2", @"Tuto3", @"Tuto4", @"Tuto5", @"Tuto6", @"Tuto7", @""];
    _pageImages = @[@"Foto1.png", @"Foto2.png", @"Foto3.png", @"Foto4.png", @"Foto5.png", @"Foto6.png", @"Foto7.png", @"Foto8.png"];
    _pageTexts = @[@"Para acessar o menu deslize o dedo da esquerda para a direita ou aperte o botão indicado.", @"Para abrir o menu deslize o dedo da esqerda para a direita", @"Você pode mudar a cor do pincel", @"Foto4.png", @"Foto5.png", @"Foto6.png", @"Foto7.png", @""];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray  *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
//    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
//    NSArray  *viewControllers = @[startingViewController];
//    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    
    [self performSegueWithIdentifier:@"skipTutorialSegue" sender:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationMaskLandscape);
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.textTutorial = self.pageTexts[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
@end
