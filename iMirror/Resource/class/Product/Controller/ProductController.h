//
//  ProductController.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/5.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductView.h"
#import "HYDataBase.h"
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>
#import "ARController.h"
#import "GAITrackedViewController.h"


@class ProductView;
@class HYDataBase;
@class ARController;

@interface ProductController : GAITrackedViewController<UIScrollViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    ProductView *productView;
    HYDataBase *hyDataBase;
    ARController *arController;
}

@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *library;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSString *query;

@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)UIBarButtonItem *leftButton;
@property(nonatomic,strong)UIBarButtonItem *rightButton;
@property(nonatomic,strong)UIBarButtonItem *addButton;

@property(nonatomic,strong)UIAlertView *alertView;
@property(nonatomic,strong)UIActionSheet *actionSheet;

@property(nonatomic,strong)UIView *bView;

@property(nonatomic)BOOL refreshBool;
@end
