//
//  JJVStoryItemStore.h
//  KnightNews
//
//  Created by james van gaasbeck on 6/25/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <Foundation/Foundation.h>

//FOUNDATION_EXPORT NSString *const TITLE_CONSTANT2;
//FOUNDATION_EXPORT NSString *const URL_CONSTANT2;
//FOUNDATION_EXPORT NSString *const POSTS_CONSTANT2;
//FOUNDATION_EXPORT NSString *const EXCERPT_CONSTANT2;
//FOUNDATION_EXPORT NSString *const CONTENT_CONSTANT2;
//FOUNDATION_EXPORT NSString *const DATE_CONSTANT2;
//FOUNDATION_EXPORT NSString *const IMAGE_CONSTANT2;
//FOUNDATION_EXPORT NSString *const AUTHOR_CONSTANT2;
//FOUNDATION_EXPORT NSString *const NAME_CONSTANT2;

@class JJVStoryItem;

@interface JJVStoryItemStore : NSObject

//the readonly array of stories
@property (nonatomic, readonly) NSArray *allItems;

//class method for retreving/initializing the array
+ (instancetype)sharedStore;

- (void)addItem:(JJVStoryItem *)storyItem;
- (JJVStoryItem *)getItemAt:(NSInteger)position;
- (NSUInteger)numberOfStories;
- (NSUInteger)indexOfStory:(JJVStoryItem *)storyItem;

//+ (void)fetchFeed;
//+(BOOL)shouldUpdateUI;
//+(void)shouldUpdateUI:(BOOL)isDone;

@end
