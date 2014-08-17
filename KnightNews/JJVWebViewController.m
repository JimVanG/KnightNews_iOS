//
//  JJVWebViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 8/16/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVWebViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface JJVWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBarButton;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation JJVWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest: self.urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateButtons
{
    self.forwardBarButton.enabled = self.webView.canGoForward;
    self.backBarButton.enabled = self.webView.canGoBack;
    self.cancelBarButton.enabled = self.webView.loading;
}

# pragma mark UIWebview Delegate method

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

@end
