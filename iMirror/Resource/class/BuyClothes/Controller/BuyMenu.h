//
//  BuyMenu.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/5/23.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HYDataBase.h"
#import "AppDelegate.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface BuyMenu : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    HYDataBase *hyDataBase;
    int test;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSMutableArray *mutableArray;

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSURL *url;
@property(nonatomic,strong)NSString *jsonString;
@property(nonatomic,strong)NSData *jsonData;
@property(nonatomic,strong)NSMutableArray *json;

@property(nonatomic,strong)NSString *name;


@end
