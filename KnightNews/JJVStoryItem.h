//
//  JJVStoryItem.h
//  KnightNews
//
//  Created by james van gaasbeck on 6/25/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JJVStoryItem : NSObject

//some public properties that define the story object
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *excerpt;
@property (nonatomic, strong) NSString *excerptParsed;
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSUInteger position;


@end
