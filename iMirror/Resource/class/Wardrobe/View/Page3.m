//
//  Page3.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "Page3.h"

@implementation Page3

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 235, 100, 30)];
        self.label1.text = @"商品名稱 : ";
        self.label1.backgroundColor = [UIColor clearColor];
        
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 265, 100, 30)];
        self.label2.text = @"商品品牌 : ";
        self.label2.backgroundColor = [UIColor clearColor];
        
        self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(5, 295, 100, 30)];
        self.label3.text = @"價錢 : ";
        self.label3.backgroundColor = [UIColor clearColor];
        
        self.label4 = [[UILabel alloc]initWithFrame:CGRectMake(5, 325, 100, 30)];
        self.label4.text = @"顏色 : ";
        self.label4.backgroundColor = [UIColor clearColor];
        
        self.label5 = [[UILabel alloc]initWithFrame:CGRectMake(110, 235, 200, 30)];
        self.label5.backgroundColor = [UIColor clearColor];
        
        self.label6 = [[UILabel alloc]initWithFrame:CGRectMake(110, 265, 100, 30)];
        self.label6.backgroundColor = [UIColor clearColor];
        
        self.label7 = [[UILabel alloc]initWithFrame:CGRectMake(110, 295, 100, 30)];
        self.label7.backgroundColor = [UIColor clearColor];
        
        self.label8 = [[UILabel alloc]initWithFrame:CGRectMake(110, 325, 160, 30)];
        self.label8.backgroundColor = [UIColor clearColor];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(60, 110, 250,100)];
        self.label.text = @"資料庫無資料...";
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont fontWithName:@"Arial" size:30];
        self.label.textColor = [UIColor blueColor];
        
        self.startView = [[UIView alloc]initWithFrame:CGRectMake(60, 80, 200, 200)];
        self.startView.backgroundColor = [UIColor blackColor];
        self.startView.layer.cornerRadius = 20.0 ;
        self.startView.alpha = 0.7 ;
        
        self.startLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 120, 40)];
        self.startLabel.backgroundColor = [UIColor clearColor];
        self.startLabel.text = @"請稍候...";
        self.startLabel.textColor = [UIColor whiteColor];
        self.startLabel.font = [UIFont fontWithName:@"Arial" size:30] ;

        
    }
    return self;
}

-(void)dealloc{
    self.scrollView = nil;
    self.imageView = nil;
    self.label1 = nil ;
    self.label2 = nil ;
    self.label3 = nil ;
    self.label4 = nil ;
    self.label5 = nil ;
    self.label6 = nil ;
    self.label7 = nil ;
    self.label8 = nil ;
    self.str0 = nil;
    self.str1 = nil;
    self.str2 = nil;
    self.str3 = nil;
    self.str4 = nil;
    self.startView = nil ;
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
