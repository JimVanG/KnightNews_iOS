//
//  JJVPreviewViewController.h
//  KnightNews
//
//  Created by james van gaasbeck on 8/6/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJVStoryItem;

@interface JJVPreviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *excerptLabel;

@property (nonatomic, strong) JJVStoryItem *item;
@property (nonatomic, strong) NSData *imageData;

@end
