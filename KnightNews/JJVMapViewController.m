//
//  JJVMapViewController.m
//  KnightNews
//
//  Created by james van gaasbeck on 8/9/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVMapViewController.h"

@interface JJVMapViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

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
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        //use their location if we have access to it
        [self.locationManager startUpdatingLocation];
        _mapView.showsUserLocation = YES;
        
    }
    else{
        if(([self.locationManager respondsToSelector:
             @selector(requestWhenInUseAuthorization)])) {
            
            //ask if we can use their location when in the app
            [self.locationManager requestWhenInUseAuthorization];
            //start using their location
            [self.locationManager startUpdatingLocation];
            _mapView.showsUserLocation = YES;
        }
    }
    
    CLLocationCoordinate2D ucf = {28.602428, -81.200060};
    
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
