//
//  CalendarEdit.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/5.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "CalendarEdit.h"

@implementation CalendarEdit

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)passTitle:(NSString *)title{
    self.title = title ;
}

-(void)passImage:(NSString *)Str{
    self.imageName = Str;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	editView = [[CalendarEditView alloc]initWithFrame:self.view.frame];
    self.view = editView ;
    
    editView.tableView.delegate = self;
    editView.tableView.dataSource = self;
    
    self.type1 = [[NSArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    self.type2 = [[NSArray alloc]initWithObjects:@"當日衣著", nil];
    self.allType = [[NSMutableArray alloc]initWithObjects:self.type1,self.type2, nil];

    [self creatSave];
}

-(void)creatSave{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"儲存" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightButton ;
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
}

-(void)save{
    
    if (self.titleStr == NULL) {
        self.titleStr = self.str1;
    }
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataTitle = [NSString stringWithFormat:@"update Calendar set title = '%@' where date = '%@' ;",self.titleStr,self.title];
    NSString *StrTitle = [NSString stringWithFormat:@"%@",updataTitle];
    [hyDataBase executeSQLMethod:StrTitle];
    
    if (self.place == NULL) {
        self.place = self.str2;
    }
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataPlace = [NSString stringWithFormat:@"update Calendar set place = '%@' where date = '%@' ;",self.place,self.title];
    NSString *StrPlace = [NSString stringWithFormat:@"%@",updataPlace];
    [hyDataBase executeSQLMethod:StrPlace];
    
    if (self.people == NULL) {
        self.people = self.str3;
    }
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataPeople = [NSString stringWithFormat:@"update Calendar set people = '%@' where date = '%@' ;",self.people,self.title];
    NSString *StrPeople = [NSString stringWithFormat:@"%@",updataPeople];
    [hyDataBase executeSQLMethod:StrPeople];
    
    if (self.main == NULL) {
        self.main = self.str4;
    }
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataMain = [NSString stringWithFormat:@"update Calendar set main = '%@' where date = '%@' ;",self.main,self.title];
    NSString *StrMain = [NSString stringWithFormat:@"%@",updataMain];
    [hyDataBase executeSQLMethod:StrMain];
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataImage = [NSString stringWithFormat:@"update Calendar set image = '%@' where date = '%@' ;",self.imageName,self.title];
    NSString *StrImage = [NSString stringWithFormat:@"%@",updataImage];
    [hyDataBase executeSQLMethod:StrImage];
    
    [self showAlertView];
    
}

-(void)showAlertView{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"儲存成功"
                                                message:nil
                                               delegate:self
                                      cancelButtonTitle:@"確定"
                                      otherButtonTitles:nil, nil];
    [self.alertView show];
    self.alertView.delegate = self ;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.allType count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.allType objectAtIndex:section]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    if (indexPath.section == 0) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 280, 30)];
        self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textField.borderStyle = UITextAutocapitalizationTypeNone;
        self.textField.returnKeyType = UIReturnKeyDone;
        self.textField.clearButtonMode = YES;
        self.textField.tag = indexPath.row;
        self.textField.delegate = self ;
        [self.textField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:self.textField];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSString *finalSelect = [NSString stringWithFormat:@"select * from Calendar where date ='%@';",self.title];
        NSMutableArray *array = [hyDataBase executeSelectCalendar:finalSelect];
        for (NSString *itemStr in array) {
            self.str1 = [NSString stringWithFormat:@"%@",array[5]];
            self.str2 = [NSString stringWithFormat:@"%@",array[2]];
            self.str3 = [NSString stringWithFormat:@"%@",array[1]];
            self.str4 = [NSString stringWithFormat:@"%@",array[3]];
        }
        
        switch (indexPath.row) {
            case 0:
                self.textField.text = self.str1;
                break;
            case 1:
                self.textField.text = self.str2;
                break;
            case 2:
                self.textField.text = self.str3;
                break;
            case 3:
                self.textField.text = self.str4;
                break;
            default:
                break;
        }
        
        cell.accessoryView = self.textField ;
        
    }
    
    
    if (indexPath.section == 1) {
        
        cell.textLabel.text = [[self.allType objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case 0:
                
                break;
                
            default:
                break;
        }
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                photoSelect = [[PhotoSelect alloc]init];
                photoSelect.delegate = self ;
                [photoSelect passImage:self.imageName];
                [self.navigationController pushViewController:photoSelect animated:YES];
                break;
            default:
                break;
        }
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
}

- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            self.titleStr = textField.text;
            if (self.titleStr != NULL) {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            break;
        case 1:
            self.place = textField.text;
            break;
        case 2:
            self.people = textField.text;
            break;
        case 3:
            self.main = textField.text;
            break;
        default:
            break;
    }
}

- (void) returnString:(NSString *)str{
    self.imageName = str ;
}

-(void)dealloc{
    editView = nil;
    hyDataBase = nil;
    photoSelect = nil;
    self.type1 = nil;
    self.type2 = nil;
    self.allType = nil;
    self.textField = nil;
    self.alertView = nil;
    self.titleStr = nil;
    self.place = nil;
    self.people = nil;
    self.main = nil;
    self.imageName = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
