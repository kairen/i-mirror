//
//  CalendarEdit.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/5.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarEditView.h"
#import "HYDataBase.h"
#import "PhotoSelect.h"

@class CalendarEditView;
@class HYDataBase;
@class PhotoSelect;

@interface CalendarEdit : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,PhotoSelectDelegate>
{
    CalendarEditView *editView;
    HYDataBase *hyDataBase;
    PhotoSelect *photoSelect;
}

-(void)passTitle:(NSString * )title;
-(void)passImage:(NSString *)Str;

@property(nonatomic,strong)NSArray *type1;
@property(nonatomic,strong)NSArray *type2;
@property(nonatomic,strong)NSMutableArray *allType ;

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)NSString *titleStr ;
@property(nonatomic,strong)NSString *place ;
@property(nonatomic,strong)NSString *people;
@property(nonatomic,strong)NSString *main;
@property(nonatomic,strong)NSString *imageName;

@property(nonatomic,strong)UIAlertView *alertView;

@property(nonatomic,strong)NSString *str1 ;
@property(nonatomic,strong)NSString *str2 ;
@property(nonatomic,strong)NSString *str3;
@property(nonatomic,strong)NSString *str4;


@end
