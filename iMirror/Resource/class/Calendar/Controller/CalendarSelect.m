//
//  CalendarSelect.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/4.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "CalendarSelect.h"

@implementation CalendarSelect

-(void)passDate:(NSString *)Date{
    self.dateStr = Date ;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(NSString*) returnDocumentsForImageName:(NSString*)imageName
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectView = [[CalendarSelectView alloc]initWithFrame:self.view.frame];
    self.view = selectView ;
    
    selectView.tableView.dataSource = self;
    selectView.tableView.delegate = self;
    selectView.tableView.pagingEnabled = NO;
    selectView.tableView.scrollEnabled = YES;
    selectView.tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectMake(0, 350, 320, 130)];
    
    self.imageView = [[UIImageView alloc]init];
    
    self.title = @"詳細資料";
        
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSString *finalSelect = [NSString stringWithFormat:@"select * from Calendar where date ='%@';",self.dateStr];
    NSMutableArray *array = [hyDataBase executeSelectCalendar:finalSelect];
    for (NSString *itemStr in array) {
        
        self.type1 = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"標題：%@\n地點：%@\n對象：%@\n備註：%@",array[5],array[2],array[1],array[3]], nil];
        self.type2 = [[NSArray alloc]initWithObjects:@"", nil];
        self.type3 = [[NSArray alloc]initWithObjects:@"刪除", nil];
        self.allType = [[NSMutableArray alloc]initWithObjects:self.type1,self.type2,self.type3, nil];

        self.imageView.image = [UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",array[0]]]];
        self.imageName = array[0];
    }
    [self creatEdit];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.allType count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.allType objectAtIndex:section]count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }
    if (indexPath.section == 1) {
        return 250;
    }
    else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //製作可重複利用的表格欄位Cell
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.textLabel setNumberOfLines:10];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:25];
            break;
        case 1:
            if (indexPath.row == 0) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [selectView.imageBtn setBackgroundImage:self.imageView.image forState:UIControlStateNormal];
                selectView.imageBtn.userInteractionEnabled = NO;
                [cell addSubview:selectView.imageBtn];

            }
            break;
        case 2:
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            break;
        default:
            break;
    }
    
    cell.textLabel.text = [[self.allType objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                [self showAlertView];
                break;
            default:
                break;
        }
        
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"";
            break;
        case 1:
            return @"當日衣著";
            break;
        default:
            return @"";
            break;
    }
}


-(void)showAlertView{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"確定要刪除嗎"
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:@"取消"
                                      otherButtonTitles:@"確定", nil];
    [self.alertView show];
    self.alertView.delegate = self ;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self deleteData];
            break;
        default:
            break;
    }
}

-(void)deleteData{
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSString *deleteData = [NSString stringWithFormat:@"delete from Calendar where date = '%@' ;",self.dateStr];
    [hyDataBase executeSQLMethod:deleteData];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)creatEdit{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"編輯" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    [self.navigationItem setRightBarButtonItem:rightButton ] ;
}

-(void)edit{
    calendarEdit = [[CalendarEdit alloc]init];
    [calendarEdit passTitle:self.dateStr];
    [calendarEdit passImage:self.imageName];
    [self.navigationController pushViewController:calendarEdit animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.alertView = nil;
    hyDataBase = nil;
    calendarEdit = nil;
    
}

@end
