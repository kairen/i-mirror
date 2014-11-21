//
//  InstallView.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/19.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "InstallView.h"

@implementation InstallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
        [self addSubview:self.tableView];
        
        self.sortLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        self.sortLabel.backgroundColor = [UIColor clearColor];
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
