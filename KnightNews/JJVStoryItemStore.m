//
//  JJVStoryItemStore.m
//  KnightNews
//
//  Created by james van gaasbeck on 6/25/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVStoryItemStore.h"
#import "JJVStoryItem.h"

//NSString *const TITLE_CONSTANT2 = @"title_plain";
//NSString *const URL_CONSTANT2 = @"url";
//NSString *const POSTS_CONSTANT2 = @"posts";
//NSString *const EXCERPT_CONSTANT2 = @"excerpt";
//NSString *const CONTENT_CONSTANT2 = @"content";
//NSString *const DATE_CONSTANT2 = @"date";
//NSString *const IMAGE_CONSTANT2 = @"image";
//NSString *const AUTHOR_CONSTANT2 = @"author";
//NSString *const NAME_CONSTANT2 = @"name";
//NSString *const CUSTOM_FIELD_CONSTANT2 = @"custom_fields";

@interface JJVStoryItemStore ()

//the private mutable array
@property (nonatomic) NSMutableArray *privateItems;

//@property (nonatomic, copy) NSMutableArray *items;

@end

@implementation JJVStoryItemStore

//static bool doneWithRequest = NO;

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

//+(BOOL)shouldUpdateUI
//{
//    return doneWithRequest;
//}
//
//+(void)shouldUpdateUI:(BOOL)isDone
//{
//    doneWithRequest = isDone;
//}

//+ (void)fetchFeed
//{
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
//    NSString *requestString = @"http://knightnews.com/api/get_recent_posts/";
//    NSURL *url = [NSURL URLWithString:requestString];
//    NSURLRequest *req = [NSURLRequest requestWithURL: url];
//    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        //NSLog(@"%@", jsonObject);
//        
//        
//        [self parseJSONObject: jsonObject];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
//            doneWithRequest = YES;
//            [dataTask cancel];
//        });
//        
//    }];
//    [dataTask resume];
//    
//}
//
//+(void)parseJSONObject:(NSDictionary *)jsonObject
//{
//    //get the list of posts (top most level of the JSON object)
//    NSMutableArray *items = jsonObject[POSTS_CONSTANT2];
//    
//    int count = 0;
//    //get each posts attributes, each post is stored in a dictionary
//    for (NSDictionary *post in items) {
//        JJVStoryItem *storyItem = [[JJVStoryItem alloc] init];
//        
//        storyItem.position = count++;
//        
//        storyItem.url = post[URL_CONSTANT2];
//        storyItem.title = post[TITLE_CONSTANT2];
//        storyItem.contents = post[CONTENT_CONSTANT2];
//        storyItem.excerpt = post[EXCERPT_CONSTANT2];
//        storyItem.date = post[DATE_CONSTANT2];
//        
//        //these fields are in their own seperate dictionaries
//        NSDictionary *innerDictionary = post[AUTHOR_CONSTANT2];
//        storyItem.author = innerDictionary[NAME_CONSTANT2];
//        
//        innerDictionary = post[CUSTOM_FIELD_CONSTANT2];
//        NSArray *customFieldsArray = innerDictionary[IMAGE_CONSTANT2];
//        //image url is inside of an array inside of a dictionary
//        storyItem.imageUrl = customFieldsArray[0];
//        storyItem.imageData = [NSData dataWithContentsOfURL:
//                               [NSURL URLWithString: storyItem.imageUrl]];
//        
//        //add to our store
//        [[JJVStoryItemStore sharedStore] addItem: storyItem];
//        
//    }
//    
//}

@end
