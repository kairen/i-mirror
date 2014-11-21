//
//  CalendarNewView.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/4.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "CalendarNewView.h"

@implementation CalendarNewView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
        self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
        [self addSubview:self.tableView];
        
    }
    return self;
}

-(void)dealloc{
    self.tableView = nil;
}

@end
