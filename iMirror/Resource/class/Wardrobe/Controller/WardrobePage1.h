//
//  WardrobePage1.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page1.h"
#import "WardrobePage2.h"
#import "GAITrackedViewController.h"

@class Page1;
@class WardrobePage2;

@interface WardrobePage1 : GAITrackedViewController
{
    Page1 *page1;
    WardrobePage2 *wardrobepage2;
}

@end
