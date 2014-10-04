//
//  KKNewsImageCache.m
//  KnightNews
//
//  Created by Kyle Kirkland on 10/3/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "KKNewsImageCache.h"

@interface KKNewsImageCache()
@property (nonatomic, strong) NSCache *imageCache;

@end
@implementation KKNewsImageCache

-(id)init
{
    self = [super init];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
    }
    
    return self;
}

-(void)addImageToCache:(UIImage*)image withKey:(NSString*)key {
    
    if (![self.imageCache objectForKey:key]) {
        [self.imageCache setObject:image forKey:key];
    }
}

-(UIImage *)getImageFromCacheWithKey:(NSString*)key {
    return [self.imageCache objectForKey:key];
}

@end
