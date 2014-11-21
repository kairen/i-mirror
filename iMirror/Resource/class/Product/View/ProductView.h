//
//  ProductView.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/5.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ProductView : UIView

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *imageButton;
@property(nonatomic,strong)NSString *imageName ;
@property(nonatomic,strong)NSNumber *imageNum;

@property(nonatomic,strong)UILabel *txtLabel;

@property(nonatomic,strong)UIActivityIndicatorView *indicator;
@property(nonatomic,strong)UIView *startView;
@property(nonatomic,strong)UILabel *startLabel ;

@property(nonatomic,strong)UIButton *shareBtn;

@property(nonatomic,strong)UIImageView *leftView;
@property(nonatomic,strong)UIImageView *rightView;


@end
