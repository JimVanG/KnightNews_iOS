//
//  JJVStoryItemStore.h
//  KnightNews
//
//  Created by james van gaasbeck on 6/25/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JJVStoryItem;

@interface JJVStoryItemStore : NSObject

//ther readonly array of stories
@property (nonatomic, readonly) NSArray *allItems;

//class method for retreving/initializing the array
+ (instancetype)sharedStore;
- (void)addItem:(JJVStoryItem *)storyItem;
- (JJVStoryItem *)getItemAt:(NSInteger)position;
- (NSUInteger)numberOfStories;
@end
