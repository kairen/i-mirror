//
//  WardrobePage2.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "WardrobePage2.h"

@interface WardrobePage2 ()

@end

@implementation WardrobePage2

-(void)passValue:(NSString *)Value{
    self.title = Value ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	page2 = [[Page2 alloc]initWithFrame:self.view.frame];
    self.view = page2;
    
    if (self.title != NULL) {
        page2.tableView.dataSource = self ;
        page2.tableView.delegate = self ;
        [self.view addSubview:page2.tableView];
        
        self.type1 = [[NSArray alloc]initWithObjects:@"上衣類",@"下身類",@"家居類",@"配件類", nil];
        self.allType = [[NSMutableArray alloc]initWithObjects:self.type1, nil];
        
        self.rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBtnEvent)];
        self.navigationItem.rightBarButtonItem =self.rightBtn;
    }
    else{
        [self.view addSubview:page2.label];
    }
    
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
}

-(void)rightBtnEvent{
    process = [[ProcessController alloc]init];
    [self.navigationController pushViewController:process animated:YES];
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
        switch (indexPath.row) {
            case 0:
                if ([self.title isEqualToString:@"男士區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Men_1.png"];
                }
                if ([self.title isEqualToString:@"女士區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Women_1.png"];
                }
                if ([self.title isEqualToString:@"兒童區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Kid_1.png"];
                }
                break;
            case 1:
                if ([self.title isEqualToString:@"男士區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Men_2.png"];
                }
                if ([self.title isEqualToString:@"女士區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Women_2.png"];
                }
                if ([self.title isEqualToString:@"兒童區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Kid_2.png"];
                }

                break;
            case 2:
                if ([self.title isEqualToString:@"男士區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Men_3.png"];
                }
                if ([self.title isEqualToString:@"女士區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Women_3.png"];
                }
                if ([self.title isEqualToString:@"兒童區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Kid_3.png"];
                }

                break;
            case 3:
                if ([self.title isEqualToString:@"男士區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Men_4.png"];
                }
                if ([self.title isEqualToString:@"女士區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Women_4.png"];
                }
                if ([self.title isEqualToString:@"兒童區"]) {
                    cell.imageView.image = [UIImage imageNamed:@"Kid_4.png"];
                }

                break;
            default:
                break;
        }
    }
    self.tableButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tableButton setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    [self.tableButton setBackgroundImage:[UIImage imageNamed:@"Button_touch.png"] forState:UIControlStateHighlighted];
    self.tableButton.frame = CGRectMake(0, 0, 30, 30);
    cell.accessoryView = self.tableButton;
    cell.textLabel.text = [[self.allType objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"";
            break;
        case 1:
            return @"分類";
            break;
        default:
            return @"";
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                wardrobePage3 = [[WardrobePage3 alloc]init];
                [wardrobePage3 passSort:self.title];
                [wardrobePage3 passTitle:@"上衣類"];
                [self.navigationController pushViewController:wardrobePage3 animated:YES];                
                break;
            case 1:
                wardrobePage3 = [[WardrobePage3 alloc]init];
                [wardrobePage3 passSort:self.title];
                [wardrobePage3 passTitle:@"下身類"];
                [self.navigationController pushViewController:wardrobePage3 animated:YES];
                break;
                
            case 2:
                wardrobePage3 = [[WardrobePage3 alloc]init];
                [wardrobePage3 passSort:self.title];
                [wardrobePage3 passTitle:@"家居類"];
                [self.navigationController pushViewController:wardrobePage3 animated:YES];
                break;
                
            case 3:
                wardrobePage3 = [[WardrobePage3 alloc]init];
                [wardrobePage3 passSort:self.title];
                [wardrobePage3 passTitle:@"配件"];
                [self.navigationController pushViewController:wardrobePage3 animated:YES];
                break;
                
            default:
                break;
        }
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    page2 = nil;
    wardrobePage3 = nil;
    self.type1 = nil;
    self.allType = nil;
}

@end
