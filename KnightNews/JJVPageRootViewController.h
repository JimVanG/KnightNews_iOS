//
//  JJVPageRootViewController.h
//  KnightNews
//
//  Created by james van gaasbeck on 7/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const TITLE_CONSTANT2;
FOUNDATION_EXPORT NSString *const URL_CONSTANT2;
FOUNDATION_EXPORT NSString *const POSTS_CONSTANT2;
FOUNDATION_EXPORT NSString *const EXCERPT_CONSTANT2;
FOUNDATION_EXPORT NSString *const CONTENT_CONSTANT2;
FOUNDATION_EXPORT NSString *const DATE_CONSTANT2;
FOUNDATION_EXPORT NSString *const IMAGE_CONSTANT2;
FOUNDATION_EXPORT NSString *const AUTHOR_CONSTANT2;
FOUNDATION_EXPORT NSString *const NAME_CONSTANT2;

@interface JJVPageRootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;


@end
