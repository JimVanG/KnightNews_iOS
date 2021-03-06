//
//  JJVReaderViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 7/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVReaderViewController.h"
#import "JJVStoryItem.h"
#import "JJVWebViewController.h"
#import "NSDate+NSDate_TimeAgo.h"

@interface JJVReaderViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end


@implementation JJVReaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                        target:self
                                        action:@selector(shareAction:)];
        self.navigationItem.rightBarButtonItem = shareButton;
        
    
        
        


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    JJVStoryItem *item = self.item;
    
    self.position = item.position;
    
    self.titleLabel.text = item.title;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    self.authorLabel.text = item.author;
    self.authorLabel.font = [UIFont italicSystemFontOfSize: 13.0f];
    self.webView.delegate = self;
    self.webView.allowsInlineMediaPlayback = YES;
    self.webView.mediaPlaybackRequiresUserAction = NO;
    
    //very important to load the base url so videos play
    
    NSString *newHtmlString = [NSString stringWithFormat:@"<h1 style='color:#333333'>%@</h1><div style='color:#999999;font-style:italic;'><div style='float:left;'>%@</div><div style='float:right'>%@</div></div><br><p style='color:#333333'>%@</p>", item.title, item.author, [item.date timeAgo], item.contents];
    [self.webView loadHTMLString: newHtmlString
                         baseURL: [NSURL URLWithString: item.url]];
    

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareAction:(id)sender
{
    UIActivityViewController *controller = [[UIActivityViewController alloc]
                                            initWithActivityItems: @[self.item.url]
                                            applicationActivities: nil];
    [self presentViewController: controller animated: YES completion: nil];
}



#pragma mark UIWebview Delegate Methods

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {

        JJVWebViewController *webVC = [[JJVWebViewController alloc] init];
        webVC.urlRequest = request;
        [self.navigationController pushViewController: webVC animated: YES];
        
        return NO;
    }
    
    return YES;
}

@end
