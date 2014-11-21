//
//  PhotoSelect.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDataBase.h"
#import "PhotoSelect.h"
#import "PhotoChoose.h"

@class HYDataBase;
@class PhotoChoose;

@protocol PhotoSelectDelegate <NSObject> //委派的名稱定義

- (void) returnString:(NSString *)str; //委派的方法實現，這方法為回傳值給ViewController

@end

@interface PhotoSelect : UIViewController<PhotoChooseDelegate,UIActionSheetDelegate>
{
    HYDataBase *hyDataBase;
    PhotoChoose *photoChoose;
}

-(void)passImage:(NSString *)Str;

@property (nonatomic, weak) id<PhotoSelectDelegate> delegate;

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSString *imageName;

@property(nonatomic,strong)UIActionSheet *actionSheet;

@end
