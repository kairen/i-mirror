//
//  AppDelegate.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarFirst.h"
#import "ProductController.h"
#import "WardrobePage1.h"
#import "InstallController.h"
#import "BuyClothesController.h"
#import "GAI.h"

@class CalendarFirst;
@class ProductController;
@class WardrobePage1;
@class InstallController;
@class BuyClothesController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate,UITabBarDelegate>

@property(nonatomic)BOOL photoInPhone;
@property(nonatomic)BOOL adInPhone;

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UITabBarController *tabBarController ;

@property(strong, nonatomic)CalendarFirst *calendar;
@property(nonatomic,strong)ProductController *product;
@property(nonatomic,strong)WardrobePage1 *wardrobe;
@property(nonatomic,strong)InstallController *install;
@property(nonatomic,strong)BuyClothesController *buyClothes;

@end
