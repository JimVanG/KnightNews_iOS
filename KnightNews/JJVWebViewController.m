//
//  JJVWebViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 8/16/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVWebViewController.h"


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
        
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                        target:self
                                        action:@selector(shareAction:)];
        self.navigationItem.rightBarButtonItem = shareButton;
        

        //        if (!self.navigationItem.leftBarButtonItem) {
        //            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"News" style: UIBarButtonItemStyleBordered target:self action:@selector(headBack:)];
        //            self.navigationItem.leftBarButtonItem = backButton;
        //        }
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{

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

- (void)shareAction:(id)sender
{
    UIActivityViewController *controller = [[UIActivityViewController alloc]
                                            initWithActivityItems:
                                            @[self.webView.request.URL.absoluteString]
                                            applicationActivities: nil];
    [self presentViewController: controller animated: YES completion: nil];
}

- (void)updateButtons
{
    self.forwardBarButton.enabled = self.webView.canGoForward;
    self.backBarButton.enabled = self.webView.canGoBack;
    self.cancelBarButton.enabled = self.webView.loading;
}


-(void) headBack:(id)sender
{
    [self dismissViewControllerAnimated: YES completion:nil];
    
}

# pragma mark UIWebview Delegate methods

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
