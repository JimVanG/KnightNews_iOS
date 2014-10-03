//
//  KKNewsImageCache.h
//  KnightNews
//
//  Created by Kyle Kirkland on 10/3/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKNewsImageCache : NSObject

-(void)addImageToCache:(UIImage*)image withKey:(NSString*)key;
-(UIImage *)getImageFromCacheWithKey:(NSString*)key;

@end
