//
//  CalendarFirst.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "CalendarFirst.h"

@implementation CalendarFirst



-(void)selectDataBase{
   hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
   self.library = [NSString stringWithFormat:@"%@",self.query];
   self.array =[hyDataBase executeSelect:self.library];
   self.num = [NSString stringWithFormat:@"%@",self.array[0]];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [self.view addSubview:calendar];
    
    self.trackedViewName = @"Calendar Screen";
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    
    self.strDate = [dateFormat stringFromDate:date];
    NSLog(@"Selected date = %@",self.strDate);
    
    self.query = [NSString stringWithFormat:@"select count(*) from Calendar where date = '%@';",self.strDate];
    [self selectDataBase];
    NSLog(@"%i",[self.num intValue]);
    
    if ([self.num intValue] == 1) {
        self.navigationItem.rightBarButtonItem = nil ;
        [self selectMain];
    }
    else{
        [self creatAddButton];
    }

}

-(void)creatAddButton{
    self.rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMain)];
    self.navigationItem.rightBarButtonItem = self.rightButton ;
}

-(void)addMain{
    calendarNew = [[CalendarNew alloc]init];
    [calendarNew passTitle:self.strDate];
    [self.navigationController pushViewController:calendarNew animated:YES];
}

-(void)selectMain{
    calendarSelect = [[CalendarSelect alloc]init];
    [calendarSelect passDate:self.strDate];
    [self.navigationController pushViewController:calendarSelect animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    hyDataBase = nil;
    self.strDate = nil;
    self.rightButton = nil;
    self.num = nil;
    self.library = nil;
    self.array = nil;
    self.query = nil;
    calendarNew = nil;
    calendarSelect = nil;
}

@end
