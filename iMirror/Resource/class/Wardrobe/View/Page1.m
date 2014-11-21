//
//  Page1.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "Page1.h"

@implementation Page1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        self.minorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background_minor.png"]];
        self.minorView.frame = CGRectMake(0, 0, 300, 300);
        [self.minorView setCenter:CGPointMake(self.frame.size.width /2,(self.frame.size.height /2)-50)];
        self.minorView.backgroundColor = [UIColor clearColor];
        
        self.WardrobeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Wardrobe_image.png"]];
        self.WardrobeImageView.frame = CGRectMake(0, 0, 240, 240);
        [self.WardrobeImageView setCenter:CGPointMake((self.frame.size.width /2),(self.frame.size.height /2)-50)];
        self.WardrobeImageView.backgroundColor = [UIColor clearColor];
        
        self.men = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.men.backgroundColor = [UIColor clearColor];
        self.men.frame = CGRectMake(0, 0, 80, 80);
        [self.men setCenter:CGPointMake((self.frame.size.width /2)-70,(self.frame.size.height /2)-98)];
        [self.men setBackgroundImage:[UIImage imageNamed:@"Men.png"] forState:UIControlStateNormal];
        
        self.women = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.women.backgroundColor = [UIColor clearColor];
        self.women.frame = CGRectMake(0, 0, 80, 80);
        [self.women setCenter:CGPointMake((self.frame.size.width /2)-50,(self.frame.size.height /2)-23)];
        [self.women setBackgroundImage:[UIImage imageNamed:@"Women.png"] forState:UIControlStateNormal];
        
        self.kids = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.kids.backgroundColor = [UIColor clearColor];
        self.kids.frame = CGRectMake(0, 0, 60, 60);
        [self.kids setCenter:CGPointMake((self.frame.size.width /2)+40,(self.frame.size.height /2)-40)];
        [self.kids setBackgroundImage:[UIImage imageNamed:@"Kid.png"] forState:UIControlStateNormal];

    }
    return self;
}

-(void)dealloc{
    self.men = nil;
    self.women = nil;
    self.kids = nil;
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
