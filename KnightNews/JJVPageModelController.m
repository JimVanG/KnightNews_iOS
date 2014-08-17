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
#import "JJVStoryItem.h"




@interface JJVPageModelController ()



@end

@implementation JJVPageModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        

        

    }
    return self;
}

#pragma mark - Convenience Methods for PageViewController

- (JJVPreviewViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([[JJVStoryItemStore sharedStore] numberOfStories] == 0) ||
        (index >= [[JJVStoryItemStore sharedStore] numberOfStories])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    JJVPreviewViewController *dataViewController = [[JJVPreviewViewController alloc] initWithNibName:@"JJVPreviewViewController" bundle:nil];
    JJVStoryItem *story = [[JJVStoryItemStore sharedStore] getItemAt: index];
    dataViewController.item = story;
    self.currentViewController = dataViewController;
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(JJVPreviewViewController *)viewController
{
    // Return the index of the given data view controller.
    return [[JJVStoryItemStore sharedStore] indexOfStory: viewController.item];

}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(JJVPreviewViewController *)viewController];

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }

    index--;

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(JJVPreviewViewController *)viewController];

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
