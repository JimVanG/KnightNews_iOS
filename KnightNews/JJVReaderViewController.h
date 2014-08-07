//
//  JJVReaderViewController.h
//  KnightNews
//
//  Created by james van gaasbeck on 7/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJVStoryItem;

@interface JJVReaderViewController : UIViewController<UIPageViewControllerDataSource>


@property (nonatomic, strong) JJVStoryItem *item;
@property (nonatomic, assign) NSUInteger position;
@property (strong, nonatomic) UIPageViewController *pageController;

-(JJVReaderViewController *)viewControllerAtIndex:(NSUInteger)index;
-(NSUInteger)indexOfViewController:(JJVReaderViewController *)viewController;
@end
