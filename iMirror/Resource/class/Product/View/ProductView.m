//
//  ProductView.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/5.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "ProductView.h"

@implementation ProductView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        self.txtLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 160, 240, 50)];
        self.txtLabel.text = @"目前沒有任何圖片";
        self.txtLabel.textColor = [UIColor blueColor];
        self.txtLabel.font = [UIFont fontWithName:@"Arial" size:30];
        self.txtLabel.backgroundColor = [UIColor clearColor];
                
        self.startView = [[UIView alloc]initWithFrame:CGRectMake(60, 80, 200, 200)];
        self.startView.backgroundColor = [UIColor blackColor];
        self.startView.layer.cornerRadius = 20.0 ;
        self.startView.alpha = 0.7 ;
        
        self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.center = CGPointMake(self.startView.bounds.size.width / 2, self.startView.bounds.size.height / 2 );
        self.indicator.color = [UIColor whiteColor];
        
        self.startLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 120, 40)];
        self.startLabel.backgroundColor = [UIColor clearColor];
        self.startLabel.text = @"請稍候...";
        self.startLabel.textColor = [UIColor whiteColor];
        self.startLabel.font = [UIFont fontWithName:@"Arial" size:30] ;
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 180, 240)];
                
        self.shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.shareBtn.backgroundColor = [UIColor clearColor];
        [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"facebook_share.png"] forState:UIControlStateNormal];
        self.shareBtn.frame = CGRectMake(self.frame.size.width - 105, self.frame.size.height - 165, 94, 52);

        self.leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, self.frame.size.height - 110)];
        self.leftView.image = [UIImage imageNamed:@"Product_leftView.png"];
        
        self.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Product_rightView.png"]];
        self.rightView.frame = CGRectMake((self.frame.size.width/2) - 60, 10, 210, 280);
        
    }
    return self;
}

-(void)dealloc{
    self.txtLabel = nil;
    self.scrollView = nil;
    self.startView = nil;
    self.indicator = nil;
    self.startLabel = nil;
    self.imageButton = nil;
    self.imageName = nil;
    self.imageView = nil;
    self.imageNum = nil;
}

@end
