//
//  BuyMenu.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/5/23.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "BuyMenu.h"

@implementation BuyMenu

#pragma mark - Check NetWork is Work (檢查網路是否有在運作)

-(BOOL) checkNetWorkIsWork
{
    SCNetworkReachabilityRef reach = SCNetworkReachabilityCreateWithName(kCFAllocatorSystemDefault, "google.com");
	SCNetworkConnectionFlags flags;
	SCNetworkReachabilityGetFlags(reach, &flags);
	
	if((kSCNetworkReachabilityFlagsReachable & flags) && !(kSCNetworkReachabilityFlagsIsWWAN & flags))
    {
		//NSLog(@" 沒有使用電信上網,但正在使用WIFI");
        test = 1;
        return YES;
	}
    else if (kSCNetworkReachabilityFlagsIsWWAN & flags)
    {
		//NSLog(@" 正在使用電信上網");
        test = 1;
        return YES;
	}
    else
    {
		//NSLog(@"網路沒有在運作");
        test = 0;
        return NO;
	}
	CFRelease(reach);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self checkNetWorkIsWork];
    
    @autoreleasepool {
        
        if (test == 0) {
            
            self.title = @"無法取得網頁資料";
            self.view.backgroundColor = [UIColor whiteColor];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告"
                                                        message:@"請連接網路"
                                                        delegate:self
                                                        cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
            [alertView show];
            alertView.delegate = self;
        }
        else{
            self.title = @"Buy衣網";
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
            
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 60, 320)];
            self.tableView.backgroundColor = [UIColor whiteColor];
            [self.tableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
            self.tableView.transform = CGAffineTransformMakeRotation(M_PI/-2);
            self.tableView.showsVerticalScrollIndicator = NO;
            self.tableView.frame = CGRectMake(0, 50, 320, 50);
            self.tableView.rowHeight = 107.0;
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            [self.view addSubview:self.tableView];
            
            self.array = [[NSArray alloc]initWithObjects:@"最新商品",@"商品下載",@"關於HANA", nil];
            self.mutableArray = [[NSMutableArray alloc]initWithObjects:self.array, nil];
            
        }
    }
    
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
    return [self.mutableArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mutableArray objectAtIndex:section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @autoreleasepool {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.backgroundColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"DFHuaZongStd-W5" size:22.0];
            cell.textLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
        cell.textLabel.text = [[self.mutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @autoreleasepool {
        NSLog(@"--------->%d",indexPath.row);
        
        [self.webView removeFromSuperview];
        [self.scrollView removeFromSuperview];
                
        switch (indexPath.row) {
            case 0:
                self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 350)];
                self.webView.backgroundColor = [UIColor clearColor];
                self.webView.scalesPageToFit = YES;
                self.webView.delegate = self;
                [self.view addSubview:self.webView];
                [self.tableView removeFromSuperview];
                [self.view addSubview:self.tableView];
                
                [self loadWebPageWithString:@"http://nens.no-ip.org/shop/"];
                
                break;
                
            case 1:
                
                self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,self.tableView.frame.origin.y + 55, 320, self.view.frame.size.height - 50)];
                self.scrollView.backgroundColor = [UIColor clearColor];
                self.scrollView.contentSize = CGSizeMake(320, 100*[self.json count]);
                self.scrollView.pagingEnabled = NO;
                self.scrollView.scrollEnabled = YES;
                self.scrollView.delegate = self ;
                self.scrollView.showsHorizontalScrollIndicator = NO ;
                self.scrollView.showsVerticalScrollIndicator = NO ;
                
                [self.tableView removeFromSuperview];
                [self.view addSubview:self.tableView];
                [self.view addSubview:self.scrollView];
                [self.scrollView flashScrollIndicators];
                
                
                for (int i = 0; i < [self.json count]; i++) {
                    
                    
                    CGRect f = CGRectMake(0, i*95, 320, 90);
                    UIView *view = [[UIView alloc] initWithFrame:f];
                    view.layer.borderWidth = 5;
                    
                    UIImage *urlImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://nens.no-ip.org/shop/img/%@",[[self.json objectAtIndex:i] objectForKey:@"img"]]]]];
                    
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
                    imageView.backgroundColor = [UIColor clearColor];
                    imageView.image = urlImage;
                    
                    
                    UILabel *labelName =[[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width*0.3, view.frame.size.height*0.1, 200, 30)];
                    labelName.backgroundColor = [UIColor clearColor];
                    labelName.text = [NSString stringWithFormat:@"商品名稱：%@",[[self.json objectAtIndex:i] objectForKey:@"title"]];
                    
                    UILabel *labelPrice =[[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width*0.3,view.frame.size.height*0.5, 200, 30)];
                    labelPrice.backgroundColor = [UIColor clearColor];
                    labelPrice.text = [NSString stringWithFormat:@"價錢：$%@",[[self.json objectAtIndex:i] objectForKey:@"price"]];
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    btn.frame = CGRectMake(view.frame.size.width*0.8, view.frame.size.height*0.35, 50, 30);
                    btn.tag = i;
                    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
                    
                    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
                    NSString *finalSelect = [NSString stringWithFormat:@"select * from jacket where name ='%@';",[[self.json objectAtIndex:i] objectForKey:@"title"]];
                    NSMutableArray *array = [hyDataBase executeSelectFinal:finalSelect];
                    for (NSString *itemStr in array) {
                        self.name = [NSString stringWithFormat:@"%@",array[2]];
                    }
                    
                    if ([[[self.json objectAtIndex:i] objectForKey:@"title"] isEqualToString:self.name]) {
                        [btn setTitle:@"已下載" forState:UIControlStateNormal];
                        btn.enabled = NO;
                    }
                    else{
                        [btn setTitle:@"下載" forState:UIControlStateNormal];
                    }
                    
                    [view addSubview:imageView];
                    [view addSubview:labelName];
                    [view addSubview:labelPrice];
                    [view addSubview:btn];
                    [self.scrollView addSubview:view];
                }
                
                break;
                
            case 2:
                
                [self loadWebPageWithString:@"http://nens.no-ip.org/shop/index.php#about"];
                [self.view addSubview:self.webView];
                [self.tableView removeFromSuperview];
                [self.view addSubview:self.tableView];
                
                break;
            default:
                break;
        }
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
        swipeUp.numberOfTouchesRequired = 1;
        swipeUp.delegate = self;
        [self.webView addGestureRecognizer:swipeUp];
        
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        swipeDown.numberOfTouchesRequired = 1;
        swipeDown.delegate = self;
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        [self.webView addGestureRecognizer:swipeDown];
    }

}

-(void)buttonClicked:(id)sender{
    @autoreleasepool {
        UIButton* btn = (UIButton*)sender;
        
        UIImage *urlImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://nens.no-ip.org/shop/img/%@",[[self.json objectAtIndex:btn.tag] objectForKey:@"img"]]]]];
        
        NSData *pngData = UIImagePNGRepresentation(urlImage);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        
        NSString *str = [NSString stringWithFormat:@"%@",urlImage];
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[str substringWithRange:NSMakeRange(10, 9)]]]; //Add the file name
        [pngData writeToFile:filePath atomically:YES]; //Write the file
        
        UIImageWriteToSavedPhotosAlbum(urlImage, self,nil, nil);
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSString *composeStr = [NSString stringWithFormat:@"insert into jacket('photo') values ('%@');",[str substringWithRange:NSMakeRange(10, 9)]];
        [hyDataBase executeSQLMethod:composeStr];
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSMutableArray *updataSex = [NSString stringWithFormat:@"update jacket set sex = 'MEN' where photo = '%@' ;",[str substringWithRange:NSMakeRange(10, 9)]];
        NSString *StrSex = [NSString stringWithFormat:@"%@",updataSex];
        [hyDataBase executeSQLMethod:StrSex];
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSMutableArray *updataSort = [NSString stringWithFormat:@"update jacket set class_1 = '上衣類' where photo = '%@' ;",[str substringWithRange:NSMakeRange(10, 9)]];
        NSString *StrSort = [NSString stringWithFormat:@"%@",updataSort];
        [hyDataBase executeSQLMethod:StrSort];
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSMutableArray *updataName = [NSString stringWithFormat:@"update jacket set name = '%@' where photo = '%@' ;",[[self.json objectAtIndex:btn.tag] objectForKey:@"title"],[str substringWithRange:NSMakeRange(10, 9)]];
        NSString *StrName = [NSString stringWithFormat:@"%@",updataName];
        [hyDataBase executeSQLMethod:StrName];
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSMutableArray *updataSign = [NSString stringWithFormat:@"update jacket set id = '無' where photo = '%@' ;",[str substringWithRange:NSMakeRange(10, 9)]];
        NSString *StrSign = [NSString stringWithFormat:@"%@",updataSign];
        [hyDataBase executeSQLMethod:StrSign];
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSMutableArray *updataPrice = [NSString stringWithFormat:@"update jacket set price = '%@' where photo = '%@' ;",[[self.json objectAtIndex:btn.tag] objectForKey:@"price"],[str substringWithRange:NSMakeRange(10, 9)]];
        NSString *StrPrice = [NSString stringWithFormat:@"%@",updataPrice];
        [hyDataBase executeSQLMethod:StrPrice];
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSMutableArray *updataColor = [NSString stringWithFormat:@"update jacket set color = '無' where photo = '%@' ;",[str substringWithRange:NSMakeRange(10, 9)]];
        NSString *StrColor = [NSString stringWithFormat:@"%@",updataColor];
        [hyDataBase executeSQLMethod:StrColor];
        
        [btn setTitle:@"已下載" forState:UIControlStateNormal];
        btn.enabled = NO;
        [self.view setNeedsDisplay];
    }
}

- (void)loadWebPageWithString:(NSString*)urlString{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    
    @autoreleasepool {
        switch (gesture.direction) {
            case UISwipeGestureRecognizerDirectionUp:
                NSLog(@"由下往上劃過");
                NSLog(@"%f,%f,%f,%f",self.tableView.frame.origin.x,self.tableView.frame.origin.y,self.tableView.frame.size.width,self.tableView.frame.size.height);
                if (self.tableView.frame.origin.y == 0) {
                    [UIView animateWithDuration:0.5 animations:^{
                        self.tableView.frame = CGRectMake(0, -50, self.tableView.frame.size.width, self.tableView.frame.size.height);
                    }];
                }
                break;
                
            case UISwipeGestureRecognizerDirectionDown:
                NSLog(@"由上往下劃過");
                NSLog(@"%f,%f,%f,%f",self.tableView.frame.origin.x,self.tableView.frame.origin.y,self.tableView.frame.size.width,self.tableView.frame.size.height);
                if (self.tableView.frame.origin.y < -50) {
                    [UIView animateWithDuration:0.5 animations:^{
                        self.tableView.frame = CGRectMake(0, +50, self.tableView.frame.size.width, self.tableView.frame.size.height);
                    }];
                }
                break;
                
            default:
                break;
        }

    }
    
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return  YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    @autoreleasepool {
        [super viewWillAppear:animated];
        
        if (test == 0) {
            
        }
        else{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
            [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        }
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    @autoreleasepool {
        [super viewDidAppear:animated];
        
        if (test == 0) {
            
        }
        else{
            self.url = [NSURL URLWithString:@"http://nens.no-ip.org/shop/index.php?ajax=goods"];
            self.jsonString = [NSString stringWithContentsOfURL:self.url encoding:NSUTF8StringEncoding error:nil];
            self.jsonData = [self.jsonString dataUsingEncoding:NSUnicodeStringEncoding];
            self.json = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%i", [self.json count]);
            NSLog(@"--:%@",[[self.json objectAtIndex:1] objectForKey:@"title"]);
        }

    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
