//
//  JJVAppDelegate.m
//  KnightNews
//
//  Created by james van gaasbeck on 6/20/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "JJVAppDelegate.h"
#import "JJVPageRootViewController.h"
#import "JJVEventsTableViewController.h"
#import "JJVSportsViewController.h"
#import "JJVMapViewController.h"
#import "JJVStoryItemStore.h"
#import "KKNewsViewController.h"
#import <Parse/Parse.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@implementation JJVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Parse Push notifications
    [Parse setApplicationId:@"keKOe5UZxrEWyX3UX4NQMLXsajd1xmG2t7op7FhP"
                  clientKey:@"0qqLP5RyNi2iF9OuHzeMJhs2VxmDOLc77uZ7yX7C"];
    
    
    //-- Set Notification (will only work in Xcode 6 +)
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced
        // in iOS 7). In that case, we skip tracking here to avoid double
        // counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    

    //set status bar to light, application wide
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //set Application wide tint color to OldGold
    [[UISegmentedControl appearance] setTintColor:UIColorFromRGB(0xCFB53B)];
    //application wide ToolBar appearence
    [[UIToolbar appearance] setTintColor:UIColorFromRGB(0xCFB53B)];
    [[UIToolbar appearance] setBarTintColor:[UIColor blackColor]];
    //Customize the navigation bar
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xCFB53B)];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          UIColorFromRGB(0xCFB53B), NSForegroundColorAttributeName,
                                                          [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    //Customize the TabBar
    [[UITabBar appearance] setBackgroundImage:[JJVAppDelegate imageFromColor: [UIColor blackColor]
                                                                     forSize:CGSizeMake(320, 50)
                                                            withCornerRadius:0]];
    [[UITabBar appearance] setTintColor: UIColorFromRGB(0xCFB53B)];
    
    KKNewsViewController *nvc = [[KKNewsViewController alloc] init];
    JJVEventsTableViewController *evc = [[JJVEventsTableViewController alloc] init];
    JJVSportsViewController *svc = [[JJVSportsViewController alloc] init];
    JJVMapViewController *mvc = [[JJVMapViewController alloc] init];
    
    UINavigationController *navController1 = [[UINavigationController alloc]
                                             initWithRootViewController:nvc];
    UINavigationController *navController2 = [[UINavigationController alloc]
                                              initWithRootViewController:evc];
    UINavigationController *navController3 = [[UINavigationController alloc]
                                              initWithRootViewController:svc];
    
    UITabBarController *tbc = [[UITabBarController alloc] init];

    tbc.viewControllers = @[navController1, navController2, navController3, mvc];
    
    self.window.rootViewController = tbc;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.


}

#pragma mark Push Notification methods

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    if (application.applicationState == UIApplicationStateInactive) {
        // The application was just brought from the background to the foreground,
        // so we consider the app as having been "opened by a push notification."
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
    
   // [PFPush handlePush:userInfo];
}

//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    if (application.applicationState == UIApplicationStateInactive) {
//        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
//    }
//}



#pragma mark TabBar Image Drawing Method

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}


@end
