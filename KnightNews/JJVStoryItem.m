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

/*
 Overriden setter to additionaly parse out extra HTML entities (i.e. & becoming &amp;)
 */
- (void)setTitle:(NSString *)title
{
    _title = [title stringByDecodingHTMLEntities];
}

/*
 Overriden setter that also sets the parsed excerpt
 */
- (void)setExcerpt:(NSString *)excerpt
{
    _excerpt = excerpt;
    self.excerptParsed = excerpt;
}

/*
 Overriden setter to additionaly parse out extra HTML
 */
- (void)setExcerptParsed:(NSString *)excerptParsed
{
    _excerptParsed = [excerptParsed stringByConvertingHTMLToPlainText];
}

@end
