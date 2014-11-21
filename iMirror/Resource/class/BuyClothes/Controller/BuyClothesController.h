//
//  BuyClothesController.h
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/5/20.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BuyMenu.h"

@class BuyMenu;

@interface BuyClothesController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BuyMenu *buyMenu;
}
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSMutableArray *mutableArray;

@end
