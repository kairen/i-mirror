//
//  FactoryController.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/22.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactoryView.h"
#import "HYDataBase.h"
#import <QuartzCore/QuartzCore.h>

@class FactoryView;
@class HYDataBase;

@interface FactoryController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>
{
    FactoryView *factoryView;
    HYDataBase *hyDataBase;
}

-(void)passImage:(UIImage *)image;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIPinchGestureRecognizer *pinch;
@property(nonatomic,strong)UIPanGestureRecognizer *pan;

@property(nonatomic,strong)NSString *executeString;

@property(nonatomic,strong)UIBarButtonItem *saveItem;

@property(nonatomic,strong)NSArray *sortArray;
@property(nonatomic,strong)NSString *firstClass;
@property(nonatomic,strong)NSString *sexName;

@property(nonatomic,strong)UIActivityIndicatorView *indicator;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIView *startView;
@property(nonatomic,strong)UILabel *startLabel ;

@property(nonatomic,strong)UIActionSheet *actionSheet;


@end
