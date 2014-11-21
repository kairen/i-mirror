//
//  PhotoChoose.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDataBase.h"

@protocol PhotoChooseDelegate <NSObject> //委派的名稱定義

- (void) returnString:(NSString *)str; //委派的方法實現，這方法為回傳值給ViewController

@end

@interface PhotoChoose : UIViewController<UIScrollViewDelegate>
{
    HYDataBase *hyDataBase ;
}

@property (nonatomic, strong) id<PhotoChooseDelegate> delegate;

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)NSNumber *imageNum;

@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *library;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSString *query;

@property(nonatomic,strong)UIActivityIndicatorView *indicator;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)UIView *startView;
@property(nonatomic,strong)UILabel *startLabel ;

@property(nonatomic,strong)UIButton *imageButton;

@property(nonatomic,strong)NSString *imageName ;

@property(nonatomic,strong)UIBarButtonItem *rightButton;

@property(nonatomic,strong)UILabel *txtLabel;

@property(nonatomic,strong)UIImageView *leftView;
@property(nonatomic,strong)UIImageView *rightView;

@end
