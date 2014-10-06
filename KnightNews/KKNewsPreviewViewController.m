//
//  KKNewsPreviewViewController.m
//  KnightNews
//
//  Created by Kyle Kirkland on 10/5/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "KKNewsPreviewViewController.h"
#import "JJVWebViewController.h"
#import "KKNewsAPI.h"
#import "JJVStoryItem.h"
#import "NSDate+NSDate_TimeAgo.h"

@interface KKNewsPreviewViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *articleDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImagView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleAuthorLabel;
@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;

@end

@implementation KKNewsPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.opaque = YES;
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUI
{
    self.articleAuthorLabel.text = self.item.author;
    self.articleTitleLabel.text = self.item.title;
    self.articleDateLabel.text = [self.item.date timeAgo];
    
    [[KKNewsAPI sharedUtilities] downloadImageForUrl:self.item.imageUrl withCompletionBlock:^(BOOL success, NSError *error, UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.articleImagView.image = image;
        });
    }];
    
    self.articleWebView.delegate = self;
    self.articleWebView.allowsInlineMediaPlayback = YES;
    self.articleWebView.mediaPlaybackRequiresUserAction = NO;
    self.articleWebView.scalesPageToFit = NO;
    //very important to load the base url so videos play
    //[self.articleWebView loadHTMLString: self.item.contents
                         //baseURL: [NSURL URLWithString: self.item.url]];
    
    [self.articleWebView loadHTMLString:[NSString stringWithFormat:@"<html><body style=\"background-color: white; font-size: 13; font-family: Georgia; color: #333333\">%@</body></html>", self.item.contents] baseURL: [NSURL URLWithString:self.item.url]];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        //        [[UIApplication sharedApplication] openURL:[request URL]];
        JJVWebViewController *webVC = [[JJVWebViewController alloc] init];
        webVC.urlRequest = request;
        [self.navigationController pushViewController: webVC animated: YES];
        return NO;
    }
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
