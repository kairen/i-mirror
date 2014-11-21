//
//  CalendarNew.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "CalendarNew.h"

@implementation CalendarNew

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

-(void)passTitle:(NSString * )title{
    self.title = title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    newView = [[CalendarNewView alloc]initWithFrame:self.view.frame];
    self.view = newView;
    
    newView.tableView.dataSource = self;
    newView.tableView.delegate = self;
    
    self.type1 = [[NSArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    self.type2 = [[NSArray alloc]initWithObjects:@"當日衣著", nil];
    self.allType = [[NSMutableArray alloc]initWithObjects:self.type1,self.type2, nil];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (appDelegate.adInPhone) {
        // 在畫面下方建立標準廣告大小的畫面。
        bannerView = [[GADBannerView alloc]
                      initWithFrame:CGRectMake(0.0,
                                               self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-(GAD_SIZE_320x50.height*2),
                                               GAD_SIZE_320x50.width,
                                               GAD_SIZE_320x50.height)];
        
        // 指定廣告的「單元識別碼」，也就是您的 AdMob 發佈商編號。
        bannerView.adUnitID = @"a1514ef47aad5dd";
        
        // 指定要復原的 UIViewController，讓執行階段在每次擷取
        // 點擊廣告的使用者後加以復原，並加進檢視階層。
        bannerView.rootViewController = self;
        [self.view addSubview:bannerView];
        
        // 啟用泛用請求，並隨廣告一起載入。
        [bannerView loadRequest:[GADRequest request]];
    }
    
    [self creatSave];
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
        
        
        switch (indexPath.row) {
            case 0:
                self.textField.placeholder = @"標題";
                break;
            case 1:
                self.textField.placeholder = @"地點";
                break;
            case 2:
                self.textField.placeholder = @"對象";
                break;
            case 3:
                self.textField.placeholder = @"備註";
                break;
            default:
                break;
        }
        
        cell.accessoryView = self.textField ;
        
    }
    
    
    if (indexPath.section == 1) {
        
        cell.textLabel.text = [[self.allType objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        
        self.tableButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.tableButton setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
        [self.tableButton setBackgroundImage:[UIImage imageNamed:@"Button_touch.png"] forState:UIControlStateHighlighted];
        self.tableButton.frame = CGRectMake(0, 0, 30, 30);
        cell.accessoryView = self.tableButton;
        
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

-(void)creatSave{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"儲存" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightButton ;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

-(void)save{
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataDate = [NSString stringWithFormat:@"insert into Calendar ('date') values ('%@');",self.title];
    NSString *StrDate = [NSString stringWithFormat:@"%@",updataDate];
    [hyDataBase executeSQLMethod:StrDate];
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataTitle = [NSString stringWithFormat:@"update Calendar set title = '%@' where date = '%@' ;",self.titleStr,self.title];
    NSString *StrTitle = [NSString stringWithFormat:@"%@",updataTitle];
    [hyDataBase executeSQLMethod:StrTitle];
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataPlace = [NSString stringWithFormat:@"update Calendar set place = '%@' where date = '%@' ;",self.place,self.title];
    NSString *StrPlace = [NSString stringWithFormat:@"%@",updataPlace];
    [hyDataBase executeSQLMethod:StrPlace];
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSMutableArray *updataPeople = [NSString stringWithFormat:@"update Calendar set people = '%@' where date = '%@' ;",self.people,self.title];
    NSString *StrPeople = [NSString stringWithFormat:@"%@",updataPeople];
    [hyDataBase executeSQLMethod:StrPeople];
    
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
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

- (void) returnString:(NSString *)str{
    self.imageName = str ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    newView = nil;
    self.type1 = nil;
    self.type2 = nil;
    self.allType = nil;
    self.textField = nil;
    self.alertView = nil;
    hyDataBase = nil;
    photoSelect = nil;
    
}

@end
