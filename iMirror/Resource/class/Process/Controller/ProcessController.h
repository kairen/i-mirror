//
//  ProcessController.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/19.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcessView.h"
#import "FactoryController.h"
#import "GAITrackedViewController.h"


@class ProcessView;
@class FactoryController;

@interface ProcessController : GAITrackedViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    ProcessView *processView;
    FactoryController *factoryController;
}

@property(nonatomic,strong)UIImagePickerController *imagePicker;

@end
