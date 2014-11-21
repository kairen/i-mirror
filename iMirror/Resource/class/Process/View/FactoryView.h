//
//  FactoryView.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/22.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactoryView : UIView

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *backImageView;

@property(nonatomic,strong)UIView *saveView;
@property(nonatomic,strong)NSString *imageName;
@property(nonatomic,strong)UITextField *nameTxt;
@property(nonatomic,strong)UITextField *signTxt;
@property(nonatomic,strong)UITextField *priceTxt;
@property(nonatomic,strong)UITextField *colorTxt;
@property(nonatomic,strong)UILabel *sex;
@property(nonatomic,strong)UILabel *sort;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *sign;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UILabel *color;
@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)UIButton *sortBtn ;
@property(nonatomic,strong)UIButton *delBtn;
@end
