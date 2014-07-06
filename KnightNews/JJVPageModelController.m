//
//  JJVPageModelController.m
//  KnightNews
//
//  Created by james van gaasbeck on 7/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVPageModelController.h"

#import "JJVReaderViewController.h"
#import "JJVStoryItemStore.h"

@implementation JJVPageModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.

    }
    return self;
}

- (JJVReaderViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([[JJVStoryItemStore sharedStore] numberOfStories] == 0) || (index >= [[JJVStoryItemStore sharedStore] numberOfStories])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    JJVReaderViewController *dataViewController = [[JJVReaderViewController alloc] init];
    //dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(JJVReaderViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return viewController.position;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(JJVReaderViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(JJVReaderViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [[JJVStoryItemStore sharedStore] numberOfStories]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


@end
