//
//  FactoryView.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/22.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "FactoryView.h"

@implementation FactoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

        self.saveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
        self.saveView.backgroundColor = [UIColor blackColor];
        self.saveView.alpha = 0.7;
        
        self.sex = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 50, 30)];
        self.sex.backgroundColor = [UIColor clearColor];
        self.sex.textColor = [UIColor whiteColor];
        self.sex.text = @"區別:";
        
        self.sort = [[UILabel alloc]initWithFrame:CGRectMake(5, 35, 50, 30)];
        self.sort.backgroundColor = [UIColor clearColor];
        self.sort.textColor = [UIColor whiteColor];
        self.sort.text = @"類別:";
        
        self.sortBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.sortBtn.frame =CGRectMake(60, 35, 50, 30);
        
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(5, 65, 80, 30)];
        self.name.backgroundColor = [UIColor clearColor];
        self.name.textColor = [UIColor whiteColor];
        self.name.text = @"商品名稱:";
        
        self.sign = [[UILabel alloc]initWithFrame:CGRectMake(5, 95, 80, 30)];
        self.sign.backgroundColor = [UIColor clearColor];
        self.sign.textColor = [UIColor whiteColor];
        self.sign.text = @"商品品牌:";
        
        self.price = [[UILabel alloc]initWithFrame:CGRectMake(5, 125, 80, 30)];
        self.price.backgroundColor = [UIColor clearColor];
        self.price.textColor = [UIColor whiteColor];
        self.price.text = @"商品價錢:";
        
        self.color = [[UILabel alloc]initWithFrame:CGRectMake(5, 155, 80, 30)];
        self.color.backgroundColor = [UIColor clearColor];
        self.color.textColor = [UIColor whiteColor];
        self.color.text = @"商品顏色:";
        
        self.nameTxt = [[UITextField alloc]initWithFrame:CGRectMake(95, 65, 100, 30)];
        self.nameTxt.borderStyle = UITextBorderStyleRoundedRect;
        
        self.signTxt = [[UITextField alloc]initWithFrame:CGRectMake(95, 95, 100, 30)];
        self.signTxt.borderStyle = UITextBorderStyleRoundedRect;
        
        self.priceTxt = [[UITextField alloc]initWithFrame:CGRectMake(95, 125, 60, 30)];
        self.priceTxt.borderStyle = UITextBorderStyleRoundedRect;
        
        self.colorTxt = [[UITextField alloc]initWithFrame:CGRectMake(95, 155, 100, 30)];
        self.colorTxt.borderStyle = UITextBorderStyleRoundedRect;
        
        self.saveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.saveBtn.frame = CGRectMake(5, 195, 50, 30);
        [self.saveBtn setTitle:@"確定" forState:UIControlStateNormal];
        
        self.delBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.delBtn.frame = CGRectMake(60, 195, 50, 30);
        [self.delBtn setTitle:@"取消" forState:UIControlStateNormal];
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
