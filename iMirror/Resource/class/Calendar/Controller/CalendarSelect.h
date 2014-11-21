//
//  CalendarSelect.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/4.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarSelectView.h"
#import "HYDataBase.h"
#import "CalendarEdit.h"
#import <QuartzCore/QuartzCore.h>

@class CalendarSelectView;
@class HYDataBase;
@class CalendarEdit;

@interface CalendarSelect : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CalendarSelectView *selectView;
    HYDataBase *hyDataBase ;
    CalendarEdit *calendarEdit;
}

-(void)passDate:(NSString *)Date;
@property(nonatomic,strong)NSString *dateStr;

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSString *imageName;

@property(nonatomic,strong)NSArray *type1;
@property(nonatomic,strong)NSArray *type2;
@property(nonatomic,strong)NSArray *type3;
@property(nonatomic,strong)NSMutableArray *allType ;

@property(nonatomic,strong)UIAlertView *alertView;

@end
