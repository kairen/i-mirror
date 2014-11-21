//
//  InstallController.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/19.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstallView.h"
#import "AppDelegate.h"
#import "GAITrackedViewController.h"


@class InstallView;

@interface InstallController : GAITrackedViewController<UITableViewDataSource,UITableViewDelegate>
{
    InstallView *installView;
}
@property(nonatomic,strong)NSArray *type1;
@property(nonatomic,strong)NSArray *type2;
@property(nonatomic,strong)NSArray *type3;
@property(nonatomic,strong)NSMutableArray *allType ;

@property(nonatomic,strong)UISwitch *switchButton;
@property(nonatomic,strong)UISwitch *switchAd;

@end
