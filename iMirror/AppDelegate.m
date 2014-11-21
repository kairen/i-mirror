//
//  AppDelegate.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [GAI sharedInstance].debug = YES;
    [GAI sharedInstance].dispatchInterval = 120;
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-39414337-1"];
    
    self.calendar = [[CalendarFirst alloc]init];
    self.calendar.title = @"穿衣曆";
    [self.calendar.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Calendar_touch.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"Calendar.png"]];
    self.calendar.tabBarItem.imageInsets = UIEdgeInsetsMake(35, 37, 60, 37);
    UINavigationController *calender = [[UINavigationController alloc]initWithRootViewController:self.calendar];
    calender.delegate = self ;
    
    self.product = [[ProductController alloc]init];
    self.product.title = @"搭配成品";
    [self.product.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Product_touch.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"Product.png"]];
    self.product.tabBarItem.imageInsets = UIEdgeInsetsMake(35, 37, 60, 37);
    UINavigationController *product = [[UINavigationController alloc]initWithRootViewController:self.product];
    product.delegate = self;
    
    self.buyClothes = [[BuyClothesController alloc]init];
    self.buyClothes.title = @"購衣網站";
    [self.buyClothes.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Buy_touch.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"Buy.png"]];
    self.buyClothes.tabBarItem.imageInsets = UIEdgeInsetsMake(35, 37, 60, 37);
    UINavigationController *buyClothes = [[UINavigationController alloc]initWithRootViewController:self.buyClothes];
    buyClothes.delegate = self;


    self.wardrobe = [[WardrobePage1 alloc]init];
    self.wardrobe.title = @"衣櫃";
    [self.wardrobe.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Wardrobe_touch.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"Wardrobe.png"]];
    self.wardrobe.tabBarItem.imageInsets = UIEdgeInsetsMake(35, 37, 60, 37);
    UINavigationController *wardrobe = [[UINavigationController alloc]initWithRootViewController:self.wardrobe];
    wardrobe.delegate = self;
    
    
    
    self.install = [[InstallController alloc]init];
    self.install.title = @"設定";
    [self.install.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Install_touch.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"Install.png"]];
    self.install.tabBarItem.imageInsets = UIEdgeInsetsMake(35, 37, 60, 37);    
    UINavigationController *install = [[UINavigationController alloc]initWithRootViewController:self.install];
    install.delegate = self;
    
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.tabBar.frame = CGRectMake(0, self.tabBarController.tabBar.frame.origin.y  - 15, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height+15);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor,
                                                           [UIFont fontWithName:@"DFHuaZongStd-W5" size:10.0], UITextAttributeFont,nil]forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }forState:UIControlStateHighlighted];
        
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"Navigation.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:5 green:86 blue:49 alpha:0], UITextAttributeTextColor,[UIFont fontWithName:@"DFHuaZongStd-W5" size:24.0], UITextAttributeFont,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRGBHex:0x5CE58D]];
    self.tabBarController.delegate = self ;
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:calender,product,buyClothes,wardrobe,install, nil];

    self.photoInPhone = YES;
    self.adInPhone = YES;
    
    self.window.rootViewController = self.tabBarController;
    [self.window addSubview:self.tabBarController.view];
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

-(void)dealloc{
    self.tabBarController = nil;
    self.calendar = nil;
    self.product = nil;
    self.buyClothes = nil;
    self.wardrobe = nil;
    self.install = nil;
}

@end
