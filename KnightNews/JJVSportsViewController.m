//
//  JJVSportsViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 8/7/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVSportsViewController.h"

@interface JJVSportsViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIWebView *webView2;

- (IBAction)changeUrl:(id)sender;
@end

@implementation JJVSportsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Sports";
        self.tabBarItem.image = [UIImage imageNamed:@"football_25"];
        self.tabBarItem.title = @"Sports";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //initial url for webview
    [self.webView loadRequest:[NSURLRequest requestWithURL:
                               [NSURL URLWithString:
                                @"http://espn.go.com/college-football/team/_/id/2116/ucf-knights"]]];
    self.webView.hidden = NO;
    //initial url for webview2
    [self.webView2 loadRequest:[NSURLRequest requestWithURL:
                               [NSURL URLWithString:
                                @"http://espn.go.com/mens-college-basketball/team/_/id/2116/ucf-knights"]]];
    self.webView2.hidden = YES;
    
    self.segmentControl = [[UISegmentedControl alloc] init];
    self.segmentControl.selectedSegmentIndex = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)changeUrl:(id)sender {
    
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.webView2.hidden = YES;
            self.webView.hidden = NO;
            break;
            
        case 1:
            self.webView.hidden = YES;
            self.webView2.hidden = NO;
            break;
            
        default:
            break;
    }
}
@end