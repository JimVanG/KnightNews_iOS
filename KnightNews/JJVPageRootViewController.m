//
//  JJVPageRootViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 7/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVPageRootViewController.h"

#import "JJVPageModelController.h"
#import "JJVStoryItemStore.h"
#import "JJVStoryItem.h"
#import "JJVPreviewViewController.h"
#import "JJVReaderViewController.h"
#import "MBProgressHUD.h"
#import "KKNewsPreviewViewController.h"

NSString *const TITLE_CONSTANT2 = @"title_plain";
NSString *const URL_CONSTANT2 = @"url";
NSString *const POSTS_CONSTANT2 = @"posts";
NSString *const EXCERPT_CONSTANT2 = @"excerpt";
NSString *const CONTENT_CONSTANT2 = @"content";
NSString *const DATE_CONSTANT2 = @"date";
NSString *const IMAGE_CONSTANT2 = @"image";
NSString *const AUTHOR_CONSTANT2 = @"author";
NSString *const NAME_CONSTANT2 = @"name";
NSString *const CUSTOM_FIELD_CONSTANT2 = @"custom_fields";





@interface JJVPageRootViewController () <UIGestureRecognizerDelegate>

@property (readonly, strong, nonatomic) JJVPageModelController *modelController;
@property (strong, nonatomic) JJVReaderViewController *startingViewController;
@property (nonatomic, assign) NSInteger currentPosition;


@end

@implementation JJVPageRootViewController

@synthesize modelController = _modelController;


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"News";
        self.tabBarItem.image = [UIImage imageNamed:@"newspaper_25"];
        self.tabBarItem.title = @"News";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"viewDidLoad");
    
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
    //the rest of the UI is set up after we've successfully retrieved our request.
    
    [self setUpUI];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"viewWillAppear");
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   // NSLog(@"viewDidAppear");
    
}

-(void)setUpUI
{
    
    self.startingViewController = [self.modelController viewControllerAtIndex: self.index];
    
    [self.pageViewController setViewControllers: @[self.startingViewController ] direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    
    self.pageViewController.dataSource = self.modelController;    
    //[self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    
    [self.pageViewController didMoveToParentViewController:self];
    
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (JJVPageModelController *)modelController
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[JJVPageModelController alloc] init];
    }
    return _modelController;
}



#pragma mark - UIPageViewController delegate methods


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    // If the page did not turn
    if (!completed)
    {
        //Do nothing because the page wasn't turned
        return;
    }
    //get the current view controller being displayed
    KKNewsPreviewViewController *current = [pageViewController.viewControllers lastObject];
    
    self.currentPosition = [[JJVStoryItemStore sharedStore] indexOfStory: current.item];
}

//Uncomment if using a page flip animation
//
//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
//{
//    if (UIInterfaceOrientationIsPortrait(orientation)) {
//        // In portrait orientation: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
//        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
//        NSArray *viewControllers = @[currentViewController];
//        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//
//        self.pageViewController.doubleSided = NO;
//        return UIPageViewControllerSpineLocationMin;
//    }
//
//    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
//    JJVPreviewViewController *currentViewController = self.pageViewController.viewControllers[0];
//    NSArray *viewControllers = nil;
//
//    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
//    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
//        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
//        viewControllers = @[currentViewController, nextViewController];
//    } else {
//        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
//        viewControllers = @[previousViewController, currentViewController];
//    }
//    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//
//
//    return UIPageViewControllerSpineLocationMid;
//}

@end
