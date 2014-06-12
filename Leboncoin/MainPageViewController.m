//
//  MainPageViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 05/03/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import "MainPageViewController.h"
#import "SearchResultViewController.h"
#import "LeboncoinAgent.h"

@interface MainPageViewController () {
    NSUInteger _currentPageIndex;
}

@end

@implementation MainPageViewController

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
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewControllerId"];
    self.pageViewController.dataSource = self;
    
    SearchResultViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    _currentPageIndex = 0;
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)jumpToPage:(int)pageIdx {
    if (pageIdx == _currentPageIndex) {
        return;
    }
    
    // Grab the viewControllers at position 4 & 5 - note, your model is responsible for providing these.
    // Technically, you could have them pre-made and passed in as an array containing the two items...
    
//    int firstIndex = 0;
//    int nextIndex = 1;
//    if (pageIdx > 0) {
//        nextIndex = pageIdx;
//        firstIndex = pageIdx-1;
//    }

    SearchResultViewController *firstViewController = [self viewControllerAtIndex:pageIdx];
//    SearchResultViewController *secondViewController = [self viewControllerAtIndex:nextIndex];
    
    //  Set up the array that holds these guys...
    
    NSArray *viewControllers = nil;
    
    viewControllers = [NSArray arrayWithObjects: firstViewController, nil];
    
    //  Now, tell the pageViewContoller to accept these guys and do the forward turn of the page.
    //  Again, forward is subjective - you could go backward.  Animation is optional but it's
    //  a nice effect for your audience.
    
    [self.pageViewController setViewControllers:viewControllers direction:pageIdx > _currentPageIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
    _currentPageIndex = pageIdx;
    
    //  Voila' - c'est fin!
}

-(IBAction)openGoogleReader:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"ghttp://www.example.com/myfile.pdf"];
    
    if (![[UIApplication sharedApplication] openURL:url])
    {
        NSLog(@"Cannot open url: %@",[url description]);
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale currentLocale]];

}

- (SearchResultViewController *)viewControllerAtIndex:(NSUInteger)index
{
    NSLog(@"%s",__FUNCTION__);
    if (([[LeboncoinAgent shareAgent].searchConditions count] == 0) || (index >= [[LeboncoinAgent shareAgent].searchConditions count])) {
        return nil;
    }
    
    
   
        
    
    
    // Create a new view controller and pass suitable data.
    SearchResultViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewControllerId"];
    pageContentViewController.pageIndex = index;
    pageContentViewController.controller = self;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"%s",__FUNCTION__);
    NSUInteger index = ((SearchResultViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    _currentPageIndex = index;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"%s",__FUNCTION__);
    NSUInteger index = ((SearchResultViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [[LeboncoinAgent shareAgent].searchConditions count]) {
        return nil;
    }
    
    _currentPageIndex = index;
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [[LeboncoinAgent shareAgent].searchConditions count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
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

@end
