//
//  KKNewsAPI.h
//  KnightNews
//
//  Created by Kyle Kirkland on 9/30/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^KKNewsRetrievedCompletionBlock)(BOOL success, NSError *error);

@interface KKNewsAPI : NSObject

+(instancetype) sharedUtilities;

-(void)downloadNewsFeedWithCompletionBlock:(KKNewsRetrievedCompletionBlock)completionBlock;


@end
