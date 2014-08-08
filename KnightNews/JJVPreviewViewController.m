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
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        tapRecognizer.delegate = self;
        //[self.view addGestureRecognizer: tapRecognizer];
        //[self.parentViewController.view addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    JJVStoryItem *item = self.item;
    
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = item.title;
    [self.titleLabel sizeToFit];
    self.authorLabel.text = item.author;
    self.authorLabel.font = [UIFont italicSystemFontOfSize: 13.5f];
    self.excerptLabel.text = item.excerptParsed;
    self.excerptLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //weird bug for 3.5inch iPhones, when going to the previous page
    //the excerpt tries to fit the entire text in the label and
    //overlaps the author and title labels.
    if (!IS_IPHONE_5 && !IS_IPAD)
        self.excerptLabel.numberOfLines = 6;
    else
        self.excerptLabel.numberOfLines = 0;
    
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                   [NSURL URLWithString: item.imageUrl]]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture recognizer methods

-(void)tap:(UIGestureRecognizer *)gr
{
    //NSLog(@"TAP");
    //initialize a readerView
    //JJVReaderViewController *readerView = [[JJVReaderViewController alloc] init];
    
    //    //pass the selected story along to the reader view
    //    NSUInteger position = [self.modelController indexOfViewController: self.startingViewController];
    //
    //    JJVStoryItem *story = [[JJVStoryItemStore sharedStore] getItemAt: position];
    //
    //    readerView.item = story;
    //
    //    //push the reader view controller onto the screen
    //    [self.navigationController pushViewController:readerView
    //                                         animated:YES];
}

@end
