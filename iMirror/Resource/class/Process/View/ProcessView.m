//
//  ProcessVIew.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/19.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "ProcessView.h"

@implementation ProcessView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        self.minorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background_minor.png"]];
        self.minorView.frame = CGRectMake(0, 0, 300, 300);
        [self.minorView setCenter:CGPointMake(self.frame.size.width /2,(self.frame.size.height /2)-50)];
        self.minorView.backgroundColor = [UIColor clearColor];
        
        self.cameraBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.cameraBtn.frame = CGRectMake(0, 0, 185, 60);
        [self.cameraBtn setCenter:CGPointMake((self.frame.size.width /2),(self.frame.size.height /2)-140)];
        [self.cameraBtn setBackgroundImage:[UIImage imageNamed:@"Camera.png"] forState:UIControlStateNormal];
        
        self.photoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.photoBtn.frame = CGRectMake(0, 0, 185, 60);
        [self.photoBtn setCenter:CGPointMake((self.frame.size.width /2),(self.frame.size.height /2)-50)];
        [self.photoBtn setBackgroundImage:[UIImage imageNamed:@"Photo.png"] forState:UIControlStateNormal];
        
        self.webBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.webBtn.frame = CGRectMake(0, 0, 185, 60);
        [self.webBtn setCenter:CGPointMake((self.frame.size.width /2),(self.frame.size.height /2)+40)];
        [self.webBtn setBackgroundImage:[UIImage imageNamed:@"Web.png"] forState:UIControlStateNormal];

    }
    return self;
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
