//
//  JJVMapViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 8/9/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVMapViewController.h"

@interface JJVMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation JJVMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"map_25"];
        self.tabBarItem.title = @"Map";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocationCoordinate2D ucf = {28.602025, -81.200820};
    
    MKMapCamera *cam = [MKMapCamera cameraLookingAtCenterCoordinate:ucf
                                                  fromEyeCoordinate:ucf
                                                        eyeAltitude:5000];
    
    [self.mapView setCamera:cam];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
