//
//  JJVStoryItem.m
//  KnightNews
//
//  Created by james van gaasbeck on 6/25/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVStoryItem.h"
#import "NSString+HTML.h"

@implementation JJVStoryItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title stringByDecodingHTMLEntities];
}

@end
