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

- (IBAction)changeUrl:(id)sender;
@end

@implementation JJVSportsViewController

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
    
    //initial url for webview
    [self.webView loadRequest:[NSURLRequest requestWithURL:
                               [NSURL URLWithString:
                                @"http://espn.go.com/college-football/team/_/id/2116/ucf-knights"]]];
    
    NSArray *segmentItems = [NSArray arrayWithObjects: @"Football", @"Basketball", nil];
    
    self.segmentControl = [[UISegmentedControl alloc] initWithItems: segmentItems];
    self.segmentControl.selectedSegmentIndex = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)changeUrl:(id)sender {
    
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            [self.webView loadRequest:[NSURLRequest requestWithURL:
                                       [NSURL URLWithString:
                                        @"http://espn.go.com/college-football/team/_/id/2116/ucf-knights"]]];
            break;
            
        case 1:
            [self.webView loadRequest:[NSURLRequest requestWithURL:
                                       [NSURL URLWithString:
                                        @"http://espn.go.com/mens-college-basketball/team/_/id/2116/ucf-knights"]]];
            break;
            
        default:
            break;
    }
}
@end
