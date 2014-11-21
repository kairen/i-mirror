//
//  WardrobePage2.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page2.h"
#import "WardrobePage3.h"
#import "GADBannerView.h"
#import "AppDelegate.h"
#import "ProcessController.h"

@class Page2;
@class WardrobePage3;
@class ProcessController;

@interface WardrobePage2 : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    Page2 *page2;
    WardrobePage3 *wardrobePage3;
    GADBannerView *bannerView;
    ProcessController *process;
}

-(void)passValue:(NSString *)Value;

@property(nonatomic,strong)NSArray *type1;
@property(nonatomic,strong)NSMutableArray *allType ;

@property(nonatomic)UIButton *tableButton;
@property(nonatomic,strong)UIBarButtonItem *rightBtn;

@end
