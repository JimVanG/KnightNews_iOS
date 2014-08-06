//
//  JJVEventItem.h
//  KnightNews
//
//  Created by james van gaasbeck on 8/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJVEventItem : NSObject

@property (nonatomic, strong) NSMutableString *title;
@property (nonatomic, strong) NSMutableString *description;
@property (nonatomic, strong) NSMutableString *date;

@end
