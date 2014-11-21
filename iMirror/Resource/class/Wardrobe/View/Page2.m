//
//  Page2.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "Page2.h"

@implementation Page2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
        self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(60, 110, 200,100)];
        self.label.text = @"還在建構中...";
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont fontWithName:@"Arial" size:30];
        self.label.textColor = [UIColor blueColor];
        
    }
    return self;
}

-(void)dealloc{
    self.tableView = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
