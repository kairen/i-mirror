//
//  WardrobePage3.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page3.h"
#import "HYDataBase.h"

@class Page3;
@class HYDataBase ;

@interface WardrobePage3 : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate>
{
    Page3 *page3;
    HYDataBase *hyDataBase;
}

-(void)passTitle:(NSString *)title;
-(void)passSort:(NSString *)sortName;

@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *library;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSString *query;

@property(nonatomic,strong)UIActivityIndicatorView *indicator;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSNumber *imageNum;

@property(nonatomic,strong)NSString *sort;

@property(nonatomic,strong)UIBarButtonItem *rightButton;

@property(nonatomic,strong)UIAlertView *alertView;


@end
