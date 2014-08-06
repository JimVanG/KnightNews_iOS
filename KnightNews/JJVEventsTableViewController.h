//
//  JJVEventsTableViewController.h
//  KnightNews
//
//  Created by james van gaasbeck on 8/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <UIKit/UIKit.h>

//Constants for XML parsing
FOUNDATION_EXPORT NSString *const EVENT_NAME;
FOUNDATION_EXPORT NSString *const EVENT_DATE;
FOUNDATION_EXPORT NSString *const EVENT_DESC;

@interface JJVEventsTableViewController : UITableViewController <NSXMLParserDelegate>

@property (nonatomic) NSXMLParser *xmlParser;

@property (nonatomic, strong) NSMutableString *tempTitle;
@property (nonatomic, strong) NSMutableString *tempDesc;
@property (nonatomic, strong) NSMutableString *tempDate;

@end
