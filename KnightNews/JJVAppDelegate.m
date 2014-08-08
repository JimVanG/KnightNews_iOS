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


@implementation JJVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    JJVPageRootViewController *nvc = [[JJVPageRootViewController alloc] init];
    JJVEventsTableViewController *evc = [[JJVEventsTableViewController alloc] init];
    JJVSportsViewController *svc = [[JJVSportsViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:nvc];
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = @[navController, evc, svc];
    
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
