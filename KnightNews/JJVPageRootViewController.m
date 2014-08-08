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
@property (strong, nonatomic) JJVPreviewViewController *startingViewController;
@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *items;

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation JJVPageRootViewController

@synthesize modelController = _modelController;


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
        [self fetchFeed];
        
        

        
    
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
    //the rest of the UI is set up after we've successfully retrieved our request.

}

-(void)setUpUI
{
    //self.startingViewController = [self.modelController viewControllerAtIndex:0];
    self.startingViewController = [self.modelController viewControllerAtIndex:0];

    NSArray *viewControllers = @[self.startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.dataSource = self.modelController;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    //    CGRect pageViewRect = self.view.bounds;
    //    pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    //    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    for (UIView *view in self.pageViewController.view.subviews) {
        if([view isKindOfClass:[UIScrollView class]])
        {
            self.scrollView = (UIScrollView *)view;
        }
    }
    tapRecognizer.delegate = self;
    [self.scrollView addGestureRecognizer: tapRecognizer];
    
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

/*
 - (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
 {
 
 }
 */

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        // In portrait orientation: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    JJVPreviewViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;
    
    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    return UIPageViewControllerSpineLocationMid;
}


#pragma mark - Networking methods

- (void)fetchFeed
{
    NSString *requestString = @"http://knightnews.com/api/get_recent_posts/";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL: url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@", jsonObject);
        
        
        [self parseJSONObject: jsonObject];
        
        
        //NSLog(@"%@", self.items);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpUI];
        });
        
    }];
    [dataTask resume];
}

-(void)parseJSONObject:(NSDictionary *)jsonObject
{
    //get the list of posts (top most level of the JSON object)
    self.items = jsonObject[POSTS_CONSTANT2];
    
    int count = 0;
    //get each posts attributes, each post is stored in a dictionary
    for (NSDictionary *post in self.items) {
        JJVStoryItem *storyItem = [[JJVStoryItem alloc] init];
        
        storyItem.position = count++;
        
        storyItem.url = post[URL_CONSTANT2];
        storyItem.title = post[TITLE_CONSTANT2];
        storyItem.contents = post[CONTENT_CONSTANT2];
        storyItem.excerpt = post[EXCERPT_CONSTANT2];
        storyItem.date = post[DATE_CONSTANT2];
        
        //these fields are in their own seperate dictionaries
        NSDictionary *innerDictionary = post[AUTHOR_CONSTANT2];
        storyItem.author = innerDictionary[NAME_CONSTANT2];
        
        innerDictionary = post[CUSTOM_FIELD_CONSTANT2];
        NSArray *customFieldsArray = innerDictionary[IMAGE_CONSTANT2];
        //image url is inside of an array inside of a dictionary
        storyItem.imageUrl = customFieldsArray[0];
        
        //add to our store
        [[JJVStoryItemStore sharedStore] addItem: storyItem];
    }
    
}

#pragma mark - Gesture recognizer methods

-(void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"TAP");
    //initialize a readerView
    JJVReaderViewController *readerView = [[JJVReaderViewController alloc] init];
    
    //pass the selected story along to the reader view
    JJVStoryItem *story = [[JJVStoryItemStore sharedStore] getItemAt: self.modelController.currentPosition];
    
    readerView.item = story;
    
    //push the reader view controller onto the screen
    [self.navigationController pushViewController:readerView
                                         animated:YES];
}

@end
