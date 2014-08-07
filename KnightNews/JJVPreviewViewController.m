//
//  JJVPreviewViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 8/6/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVPreviewViewController.h"
#import "JJVStoryItem.h"

@interface JJVPreviewViewController ()

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
    
    self.titleLabel.text = item.title;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    self.authorLabel.text = item.author;
    self.authorLabel.font = [UIFont italicSystemFontOfSize: 13.5f];
    self.excerptLabel.text = item.excerptParsed;
    self.excerptLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.excerptLabel.numberOfLines = 0;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
