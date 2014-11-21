//
//  HYDataBase.m
//  SQLiteText
//
//  Created by 陳 柏瑜 on 12/10/15.
//  Copyright (c) 2012年 brian. All rights reserved.
//

#import "HYDataBase.h"

@implementation HYDataBase

#pragma mark - HYDataBase init

-(id)hyDataBaseWithDataBasePath:(NSString *)dataBase{
    self.db_Name = dataBase;
    [self checkDataBaseForFileName:self.db_Name];
    return self;
}

#pragma mark - DataBase check exist and copy item

-(void) checkDataBaseForFileName:(NSString*)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *url = [[self getDocuments] stringByAppendingPathComponent:fileName];
    
    if([fileManager fileExistsAtPath:url]){
        
    }
    else{
        
        [fileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@""] toPath:url error:nil];
    }
}

#pragma mark - Get Doncuments HomeDirectory

-(NSString *) getDocuments{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

#pragma mark - Select Sqlite Table Method

-(NSMutableArray *)executeSelect:(NSString *)exec_query{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    sqlite3 *database;
    if (sqlite3_open([[[self getDocuments] stringByAppendingPathComponent:self.db_Name]UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *stm;
        if (sqlite3_prepare_v2(database, [exec_query UTF8String], -1, &stm, NULL) == SQLITE_OK) {
            while (sqlite3_step(stm) == SQLITE_ROW)
            {
                
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 0)]];

            }
        }
    }
    return array;
    sqlite3_close(database);
}

#pragma mark - Select Sqlite Table Method Final

-(NSMutableArray *)executeSelectFinal:(NSString *)exec_query{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    sqlite3 *database;
    if (sqlite3_open([[[self getDocuments] stringByAppendingPathComponent:self.db_Name]UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *stm;
        if (sqlite3_prepare_v2(database, [exec_query UTF8String], -1, &stm, NULL) == SQLITE_OK) {
            while (sqlite3_step(stm) == SQLITE_ROW)
            {    
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 0)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 1)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 2)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 3)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 4)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 5)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 6)]];
                
            }
        }
    }
    return array;
    sqlite3_close(database);
}

#pragma mark - Select Sqlite Table Method Calendar

-(NSMutableArray *)executeSelectCalendar:(NSString *)exec_query{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    sqlite3 *database;
    if (sqlite3_open([[[self getDocuments] stringByAppendingPathComponent:self.db_Name]UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *stm;
        if (sqlite3_prepare_v2(database, [exec_query UTF8String], -1, &stm, NULL) == SQLITE_OK) {
            while (sqlite3_step(stm) == SQLITE_ROW)
            {
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 0)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 1)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 2)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 3)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 4)]];
                [array addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 5)]];

                
            }
        }
    }
    return array;
    sqlite3_close(database);
}


#pragma mark - Insert & Update Sqlite Table Method

-(void)executeSQLMethod:(NSString *)exec_query{

    sqlite3 *database;
    
    if (sqlite3_open([[[self getDocuments]stringByAppendingPathComponent:self.db_Name]UTF8String], &database) == SQLITE_OK){
        char *error;
        if (sqlite3_exec(database, [exec_query UTF8String], NULL, NULL, &error) == SQLITE_OK) {
            
        }
        else{
            
        }
    }
    sqlite3_close(database);
}


@end
