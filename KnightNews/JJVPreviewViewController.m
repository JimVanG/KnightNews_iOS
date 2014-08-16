//
//  JJVPreviewViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 8/6/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVPreviewViewController.h"
#import "JJVStoryItem.h"
#import "Constants.h"


@interface JJVPreviewViewController () <UIGestureRecognizerDelegate>


@end

@implementation JJVPreviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    JJVStoryItem *item = self.item;
    
    if (!IS_IPHONE_5 && !IS_IPAD){
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = item.title;
        [self.titleLabel sizeToFit];
        self.authorLabel.font = [UIFont italicSystemFontOfSize: 12];
        self.authorLabel.text = item.author;
        self.excerptLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.excerptLabel.numberOfLines = 0;
        self.excerptLabel.text = item.excerptParsed;
    }
    else if (!IS_IPHONE && !IS_IPHONE_5 && IS_IPAD){
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = item.title;
        [self.titleLabel sizeToFit];
        self.authorLabel.font = [UIFont italicSystemFontOfSize: 16];
        self.authorLabel.text = item.author;
        self.excerptLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.excerptLabel.numberOfLines = 0;
        self.excerptLabel.text = item.excerptParsed;
    }
    else{
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = item.title;
        [self.titleLabel sizeToFit];
        self.authorLabel.font = [UIFont italicSystemFontOfSize: 14];
        self.authorLabel.text = item.author;
        self.excerptLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.excerptLabel.numberOfLines = 0;
        self.excerptLabel.text = item.excerptParsed;

    }
    
    self.imageView.image = [UIImage imageWithData:self.imageData];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
