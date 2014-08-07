//
//  JJVPageModelController.h
//  KnightNews
//
//  Created by james van gaasbeck on 7/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <Foundation/Foundation.h>


@class JJVReaderViewController;

@interface JJVPageModelController : NSObject <UIPageViewControllerDataSource>

-(JJVReaderViewController *)viewControllerAtIndex:(NSUInteger)index;
-(NSUInteger)indexOfViewController:(JJVReaderViewController *)viewController;

@end
