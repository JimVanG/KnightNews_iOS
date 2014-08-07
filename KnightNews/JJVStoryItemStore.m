//
//  JJVStoryItemStore.m
//  KnightNews
//
//  Created by james van gaasbeck on 6/25/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVStoryItemStore.h"
#import "JJVStoryItem.h"

@interface JJVStoryItemStore ()

//the private mutable array
@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation JJVStoryItemStore

+(instancetype)sharedStore
{
    static JJVStoryItemStore *sharedStore;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedStore = [[self alloc] initPrivate];});
    
    return sharedStore;
}

//the real private initializer
-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[JJVStoryItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (void)addItem:(JJVStoryItem *)storyItem
{
    [self.privateItems addObject:storyItem];
}

- (JJVStoryItem *)getItemAt:(NSInteger)position
{
    return [self.privateItems objectAtIndex: position];
}

- (NSUInteger)numberOfStories
{
    return [self.privateItems count];
}

-(NSUInteger)indexOfStory:(JJVStoryItem *)storyItem
{
    return [self.privateItems indexOfObject: storyItem];
}


@end
