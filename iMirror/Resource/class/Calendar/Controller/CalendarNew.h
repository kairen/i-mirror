//
//  CalendarNew.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarNewView.h"
#import "CalendarFirst.h"
#import "HYDataBase.h"
#import "PhotoSelect.h"
#import "GADBannerView.h"
#import "AppDelegate.h"

@class CalendarNewView;
@class HYDataBase;
@class PhotoSelect;

@interface CalendarNew :UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,PhotoSelectDelegate>
{
    CalendarNewView *newView;
    HYDataBase *hyDataBase;
    PhotoSelect *photoSelect;
    GADBannerView *bannerView;

}
-(void)passTitle:(NSString * )title;

@property(nonatomic,strong)NSArray *type1;
@property(nonatomic,strong)NSArray *type2;
@property(nonatomic,strong)NSMutableArray *allType ;

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)NSString *titleStr ;
@property(nonatomic,strong)NSString *place ;
@property(nonatomic,strong)NSString *people;
@property(nonatomic,strong)NSString *main;
@property(nonatomic,strong)NSString *imageName;

@property(nonatomic,strong)UIAlertView *alertView;

@property(nonatomic)UIButton *tableButton;

@end
