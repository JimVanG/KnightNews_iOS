//
//  JJVNewsTableViewController.h
//  KnightNews
//
//  Created by james van gaasbeck on 6/20/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <UIKit/UIKit.h>

//Constants for JSON parsing
FOUNDATION_EXPORT NSString *const TITLE_CONSTANT;
FOUNDATION_EXPORT NSString *const URL_CONSTANT;
FOUNDATION_EXPORT NSString *const POSTS_CONSTANT;
FOUNDATION_EXPORT NSString *const EXCERPT_CONSTANT;
FOUNDATION_EXPORT NSString *const CONTENT_CONSTANT;
FOUNDATION_EXPORT NSString *const DATE_CONSTANT;
FOUNDATION_EXPORT NSString *const IMAGE_CONSTANT;
FOUNDATION_EXPORT NSString *const AUTHOR_CONSTANT;
FOUNDATION_EXPORT NSString *const NAME_CONSTANT;

@class JJVWebViewController;

@interface JJVNewsTableViewController : UITableViewController

@property (nonatomic) JJVWebViewController *webViewController;

@end
