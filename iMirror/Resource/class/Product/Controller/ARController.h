//
//  ARController.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDataBase.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <CoreGraphics/CoreGraphics.h>

@interface ARController : UIImagePickerController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate>
{
    HYDataBase *hyDataBase ;
}

-(id) initWithSourceType:(UIImagePickerControllerSourceType)type;

-(void)passValue:(NSString *)text;

@property(nonatomic,strong)NSString *mediaType;
@property(nonatomic,strong)NSString *passText;

@property(nonatomic,strong)UIImage *copiedImage;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *backImageView;
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *library;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSString *query;

@property(nonatomic,strong)UIView *sideView;
@property(nonatomic,strong)UIButton *startBtn;
@property(nonatomic,strong)UIButton *endBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIButton *btn4;
@property(nonatomic,strong)UILabel *secondLabel;
@property(nonatomic,strong)UILabel *zoomLabel;
@property(nonatomic,strong)UILabel *moveLabel;
@property(nonatomic,strong)UIButton *zoomBtn;
@property(nonatomic,strong)UIButton *moveBtn;
@property(nonatomic,strong)UIButton *clearBtn;
@property(nonatomic,strong)UIView *discernZoom;
@property(nonatomic,strong)UIView *discernMove;

@property(nonatomic,strong)UIPanGestureRecognizer *pan;
@property(nonatomic,strong)UIPinchGestureRecognizer *Pinch;

@property(nonatomic,strong)NSString *sexName;


@end
