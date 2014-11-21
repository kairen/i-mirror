//
//  WardrobePage3.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "WardrobePage3.h"

@interface WardrobePage3 ()

@end

@implementation WardrobePage3

-(void)passTitle:(NSString *)title{
    self.title = title ;
    NSLog(@"%@",self.title);
}

-(void)passSort:(NSString *)sortName{
    
    if ([sortName isEqualToString:@"男士區"]) {
        self.sort = @"MEN";
    }
    if ([sortName isEqualToString:@"女士區"]) {
        self.sort = @"WOMEN";
    }
    if ([sortName isEqualToString:@"兒童區"]) {
        self.sort = @"KID";
    }
    
    NSLog(@"%@",self.sort);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	page3 = [[Page3 alloc]initWithFrame:self.view.frame];
    self.view = page3;
    
    [self judge];
    
    if ([self.num isEqualToString:@"0"]!= 1) {
        
        CGRect frame = CGRectMake(0, 0, 320, 240);
        
        int pageCount = [self.num intValue];
        self.imageNum = [[NSNumber alloc]initWithInt:pageCount];
        
        page3.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        page3.scrollView.contentSize = CGSizeMake(320*pageCount, 240);
        page3.scrollView.pagingEnabled = YES;
        page3.scrollView.scrollEnabled = NO;
        page3.scrollView.delegate = self ;
        page3.scrollView.showsHorizontalScrollIndicator = NO ;
        page3.scrollView.backgroundColor = [UIColor clearColor];
        
        //Add our scroll view to the main window's view hierarchy
        [self.view addSubview:page3.scrollView];
        
        //Flash the scroll view indicators when the window is visible
        [page3.scrollView flashScrollIndicators];
        
        [self.view addSubview:page3.label1];
        [self.view addSubview:page3.label2];
        [self.view addSubview:page3.label3];
        [self.view addSubview:page3.label4];
        
        [self waitStart];
        [self creatRightButton];
    }
    else{
        [self.view addSubview:page3.label];
    }

}

-(void)creatRightButton{
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"刪除" style:UIBarButtonItemStylePlain target:self action:@selector(showAlertView)];
    [self.navigationItem setRightBarButtonItem:self.rightButton ] ;
}

-(void)showAlertView{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                message:@"你確定要刪掉嗎"
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
            [self deleteImage];
            break;
        default:
            break;
    }
}

-(void)deleteImage{
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    self.library = [NSString stringWithFormat:@"delete from jacket where photo = '%@' ;",page3.str0];
    [hyDataBase executeSQLMethod:self.library];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",page3.imageName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:NULL];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)judge{
    self.query = [NSString stringWithFormat:@"select count(*) from jacket where class_1 = '%@' AND sex ='%@' ;",self.title,self.sort];
    [self selectDataBase];
    NSLog(@"%@",self.num);
}

-(void)judgePhoto{
    self.query = [NSString stringWithFormat:@"select photo from jacket where class_1 = '%@' AND sex = '%@';",self.title,self.sort];
    [self selectDataBase];
}

-(void)waitStart{
    
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.center = CGPointMake(page3.startView.bounds.size.width / 2, page3.startView.bounds.size.height / 2 );
    self.indicator.color = [UIColor whiteColor];
    [self.indicator startAnimating];
    [page3.imageView addSubview:self.indicator];
    
    [page3.startView addSubview:self.indicator];
    [page3.startView addSubview:page3.startLabel];
    [self.view addSubview:page3.startView];
    
    self.progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    float theInterval = 0.5 / 9.0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:theInterval target:self selector:@selector(running) userInfo:nil repeats:YES];
    
}

- (void)running {
    
    if (self.progressView.progress != 1.0) {
        self.progressView.progress = self.progressView.progress + 0.1;
    }
    else {
        if (self.progressView.progress == 1.0) {
        }
        [self firstSelect];
        [self loadPhoto];
        [page3.startView removeFromSuperview];
        page3.scrollView.scrollEnabled = YES ;
        [self.timer invalidate];
        self.timer = nil;
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = scrollView.frame.size.width;
    NSInteger currentPage = ((scrollView.contentOffset.x - width / 2) / width) + 1;
    page3.imageView.tag = currentPage ;
    
    //    NSLog(@"%f",scrollView.contentOffset.x/320);
    //    NSLog(@"%i",currentPage);
    
    if (scrollView.contentOffset.x/320 == currentPage) {
        [page3.label5 removeFromSuperview];
        [page3.label6 removeFromSuperview];
        [page3.label7 removeFromSuperview];
        [page3.label8 removeFromSuperview];
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSString *finalSelect = [NSString stringWithFormat:@"select * from jacket where photo ='%@';",self.array[currentPage]];
        NSMutableArray *array = [hyDataBase executeSelectFinal:finalSelect];
        
        for (NSString *itemStr in array) {
            page3.str0 = [NSString stringWithFormat:@"%@",array[0]];
            page3.str1 = [NSString stringWithFormat:@"%@",array[1]];
            page3.str2 = [NSString stringWithFormat:@"%@",array[2]];
            page3.str3 = [NSString stringWithFormat:@"%@",array[3]];
            page3.str4 = [NSString stringWithFormat:@"%@",array[4]];
        }
        page3.label5.text = [NSString stringWithFormat:@"%@",page3.str2];
        page3.label6.text = [NSString stringWithFormat:@"%@",page3.str1];
        page3.label7.text = [NSString stringWithFormat:@"$%@",page3.str3];
        page3.label8.text = [NSString stringWithFormat:@"%@",page3.str4];
        [self.view addSubview:page3.label5];
        [self.view addSubview:page3.label6];
        [self.view addSubview:page3.label7];
        [self.view addSubview:page3.label8];
    }
    
}

-(NSString*) returnDocumentsForImageName:(NSString*)imageName
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
}

-(void)loadPhoto{
    for (int i=0; i< [self.imageNum intValue]; i++) {
        
        [self judgePhoto];
        page3.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 0, 180, 240)];
        page3.imageView.image = [UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@.png",self.array[i]]]];
                
        if (page3.imageView.image == NULL ) {
            page3.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.array[i]]];
        }
        
        CGRect f = CGRectMake(i*320, 0, 320, 240);
        UIView *view = [[UIView alloc] initWithFrame:f];
        view.backgroundColor = [UIColor clearColor];
        [view addSubview:page3.imageView];
        [page3.scrollView addSubview:view];
        
    }
}

-(void)firstSelect{
    
    [self judgePhoto];
    
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    NSString *finalSelect = [NSString stringWithFormat:@"select * from jacket where photo ='%@';",self.array[0]];
    NSMutableArray *array = [hyDataBase executeSelectFinal:finalSelect];
    for (NSString *itemStr in array) {
        page3.str0 = [NSString stringWithFormat:@"%@",array[0]];
        page3.str1 = [NSString stringWithFormat:@"%@",array[1]];
        page3.str2 = [NSString stringWithFormat:@"%@",array[2]];
        page3.str3 = [NSString stringWithFormat:@"%@",array[3]];
        page3.str4 = [NSString stringWithFormat:@"%@",array[4]];
    }
    page3.label5 = [[UILabel alloc]initWithFrame:CGRectMake(110, 235, 200, 30)];
    page3.label5.text = [NSString stringWithFormat:@"%@",page3.str2];
    page3.label5.backgroundColor = [UIColor clearColor];
    
    page3.label6 = [[UILabel alloc]initWithFrame:CGRectMake(110, 265, 100, 30)];
    page3.label6.text = [NSString stringWithFormat:@"%@",page3.str1];
    page3.label6.backgroundColor = [UIColor clearColor];
    
    page3.label7 = [[UILabel alloc]initWithFrame:CGRectMake(110, 295, 100, 30)];
    page3.label7.text = [NSString stringWithFormat:@"$%@",page3.str3];
    page3.label7.backgroundColor = [UIColor clearColor];
    
    page3.label8 = [[UILabel alloc]initWithFrame:CGRectMake(110, 325, 160, 30)];
    page3.label8.text = [NSString stringWithFormat:@"%@",page3.str4];
    page3.label8.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:page3.label5];
    [self.view addSubview:page3.label6];
    [self.view addSubview:page3.label7];
    [self.view addSubview:page3.label8];
}

-(void)selectDataBase{
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    self.library = [NSString stringWithFormat:@"%@",self.query];
    self.array =[hyDataBase executeSelect:self.library];
    self.num = [NSString stringWithFormat:@"%@",self.array[0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    page3 = nil;
    hyDataBase = nil;
}

@end
