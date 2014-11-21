//
//  HYDataBase.h
//  SQLiteText
//
//  Created by 陳 柏瑜 on 12/10/15.
//  Copyright (c) 2012年 brian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface HYDataBase : NSObject

@property(nonatomic,strong)NSString *db_Name;

-(id)hyDataBaseWithDataBasePath:(NSString *)dataBase;

-(NSMutableArray *)executeSelect:(NSString *)exec_query;
-(NSMutableArray *)executeSelectFinal:(NSString *)exec_query;
-(NSMutableArray *)executeSelectCalendar:(NSString *)exec_query;

-(void)executeSQLMethod:(NSString *)exec_query;

@end
