//
//  CalendarFirst.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"
#import "HYDataBase.h"
#import "CalendarNew.h"
#import "CalendarSelect.h"
#import "GAITrackedViewController.h"

@class CalendarNew;
@class HYDataBase;
@class VRGCalendarView;
@class CalendarSelect;

@interface CalendarFirst : GAITrackedViewController<VRGCalendarViewDelegate>
{
    HYDataBase *hyDataBase ;
    CalendarNew *calendarNew;
    CalendarSelect *calendarSelect;
}
@property(nonatomic,strong)NSString *strDate;
@property(nonatomic,strong)UIBarButtonItem *rightButton;

@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *library;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSString *query;

@end
