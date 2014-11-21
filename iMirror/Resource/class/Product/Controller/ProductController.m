//
//  ProductController.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/5.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "ProductController.h"

@implementation ProductController

-(void)selectDataBase{
    @autoreleasepool {
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        self.library = [NSString stringWithFormat:@"%@",self.query];
        self.array =[hyDataBase executeSelect:self.library];
        self.num = [NSString stringWithFormat:@"%@",self.array[0]];
    }
}

- (void)viewDidLoad
{	
    @autoreleasepool {
        
        [super viewDidLoad];
        productView = [[ProductView alloc]initWithFrame:self.view.frame];
        self.view = productView ;
        self.tabBarController.tabBar.userInteractionEnabled = NO;
        [self refresh];
        
        self.trackedViewName = @"Product Screen";
        
        self.refreshBool = NO;
    }
}

-(void)creatScrollView{
    
    @autoreleasepool {
        self.query = @"select count(*) from Outfit;";
        [self selectDataBase];
        
        if ([self.num intValue] == 0) {
            [self.view addSubview:productView.txtLabel];
        }
        else{
            [productView.txtLabel removeFromSuperview];
            [self.view addSubview:productView.leftView];
            int pageCount = [self.num intValue];
            productView.imageNum = [[NSNumber alloc]initWithInt:pageCount];
            
            productView.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 10, 72, self.view.frame.size.height - 30)];
            productView.scrollView.backgroundColor = [UIColor clearColor];
            productView.scrollView.contentSize = CGSizeMake(72, 100*pageCount);
            productView.scrollView.pagingEnabled = NO;
            productView.scrollView.scrollEnabled = NO;
            productView.scrollView.delegate = self ;
            productView.scrollView.showsHorizontalScrollIndicator = NO ;
            productView.scrollView.showsVerticalScrollIndicator = NO ;
            
            [self.view addSubview:productView.scrollView];
            [productView.scrollView flashScrollIndicators];
        }
    }
}

-(void)refresh{
    @autoreleasepool {
        [productView.txtLabel removeFromSuperview];
        [productView.imageView removeFromSuperview];
        [productView.scrollView removeFromSuperview];
        [productView.shareBtn removeFromSuperview];
        [productView.leftView removeFromSuperview];
        [productView.rightView removeFromSuperview];
        [self.bView removeFromSuperview];
        self.bView = nil;
        productView.scrollView = nil;
        
        self.num = nil;
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        
        [self waitStart];
        
        productView.startLabel.text = @"重新整理中...";
        productView.startLabel.font = [UIFont fontWithName:@"Arial" size:20];
    }
}

-(void)waitStart{
    @autoreleasepool {
        [productView.indicator startAnimating];
        [productView.imageView addSubview:productView.indicator];
        
        [productView.startView addSubview:productView.indicator];
        [productView.startView addSubview:productView.startLabel];
        [self.view addSubview:productView.startView];
        
        self.progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        float theInterval = 0.5 / 9.0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:theInterval target:self selector:@selector(running) userInfo:nil repeats:YES];
    }
}

- (void)running {
    @autoreleasepool {
        if (self.progressView.progress != 1.0) {
            self.progressView.progress = self.progressView.progress + 0.1;
        }
        else {
            if (self.progressView.progress == 1.0) {
            }
            
            self.query = @"select count(*) from Outfit;";
            [self selectDataBase];
            
            [self creatScrollView];
            
            if ([self.num intValue] == 0) {
                [productView.startView removeFromSuperview];
                [self creatAddButton];
                [self.timer invalidate];
                self.timer = nil;
                [productView.shareBtn removeFromSuperview];
                self.tabBarController.tabBar.userInteractionEnabled = YES;
                return;
            }
            else{
                self.tabBarController.tabBar.userInteractionEnabled = YES;
                [productView.imageButton removeFromSuperview];
                [self loadPhoto];
                [productView.startView removeFromSuperview];
                [productView.txtLabel removeFromSuperview];
                productView.scrollView.scrollEnabled = YES ;
                [self share];
                [self creatRightButton];
                [self.timer invalidate];
                self.timer = nil;
            }
        }
 
    }
}

-(NSString*) returnDocumentsForImageName:(NSString*)imageName
{
    @autoreleasepool {
        return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    }
}

-(void)loadPhoto{
    
    @autoreleasepool {
        self.query = @"select photo from Outfit;";
        [self selectDataBase];
        
        for (int i = 0; i < [productView.imageNum intValue]; i++) {
            
            NSLog(@"%@",self.array[i]);
            
            productView.imageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            productView.imageButton.frame = CGRectMake(0, 0, 72, 90);
            [productView.imageButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",self.array[i]]]] forState:UIControlStateNormal];
            [productView.imageButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
            [productView.imageButton setTag: i];
            CGRect f = CGRectMake(0, i*100, 72, 90);
            self.bView = [[UIView alloc] initWithFrame:f];
            
            [self.bView addSubview:productView.imageButton];
            [productView.scrollView addSubview:self.bView];
        }
        
        productView.imageView.image = [UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",self.array[0]]]];
        productView.imageView.frame =CGRectMake((self.view.frame.size.width/2) - 50, 15, 190, 270);
        productView.imageName = [NSString stringWithFormat:@"%@",self.array[0]];
        [self.view addSubview:productView.imageView];
        [self.view addSubview:productView.rightView];
    }
    
}

-(void)buttonClicked:(id)sender{
    
    @autoreleasepool {
        [productView.imageView removeFromSuperview];
        [productView.rightView removeFromSuperview];
        UIButton* btn = (UIButton*)sender;
        int x = 0;
        
        int y = [productView.imageNum intValue];
        
        while ((x < y)) {
            
            if (x == btn.tag) {
                productView.imageView.frame =CGRectMake((self.view.frame.size.width/2) - 50, 15, 190, 270);
                productView.imageView.image = [UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",self.array[x]]]];
                productView.imageName = [NSString stringWithFormat:@"%@",self.array[x]];
                [self.view addSubview:productView.imageView];
                [self.view addSubview:productView.rightView];
            }
            x++;
        }
    }
    
}

-(void)creatAddButton{
    @autoreleasepool {
        self.addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openCamera)];
        [self.navigationItem setRightBarButtonItem:self.addButton];
    }
}

-(void)creatRightButton{
    @autoreleasepool {
        self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"編輯" style:UIBarButtonItemStylePlain target:self action:@selector(sheet)];
        [self.navigationItem setRightBarButtonItem:self.rightButton ] ;
    }
}

-(void)openCamera{
    
    @autoreleasepool {
        arController = [[ARController alloc]initWithSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:arController animated:YES completion:nil];
        
        self.query = @"select count(*) from Outfit;";
        [self selectDataBase];
        
        if ([self.num intValue] == 0) {
            [self creatAddButton];
        }
        else{
            [self creatRightButton];
        }
    }
    
}

#pragma mark - 產生ActionSheet

-(void)sheet{
    
    @autoreleasepool {
        self.actionSheet = [[UIActionSheet alloc]initWithTitle:@"選單"
                                                      delegate:self
                                             cancelButtonTitle:@"返回"
                                        destructiveButtonTitle:@"刪除"
                                             otherButtonTitles:@"新增圖片",
                            nil];
        [self.actionSheet setTag:0];
        [self.actionSheet showFromTabBar:self.tabBarController.tabBar];
    }
    
}

#pragma mark - 判斷ActionSheet按鈕事件

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    @autoreleasepool {
        if (actionSheet.tag == 0) {
            switch (buttonIndex) {
                case 0:
                    [self showAlertView];
                    break;
                case 1:
                    [self openCamera];
                    break;
                case 2:
                    break;
                default:
                    break;
            }
        }
    }
    
}

-(void)showAlertView{
    @autoreleasepool {
        self.alertView = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                    message:@"你確定要刪掉嗎"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"確定", nil];
        [self.alertView show];
        self.alertView.delegate = self ;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    @autoreleasepool {
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
}

-(void)deleteImage{
    @autoreleasepool {
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        self.library = [NSString stringWithFormat:@"delete from Outfit where photo = '%@' ;",productView.imageName];
        [hyDataBase executeSQLMethod:self.library];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",productView.imageName]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:NULL];
        
        [self refresh];
        productView.startLabel.text = @"刪除中...";
        productView.startLabel.font = [UIFont fontWithName:@"Arial" size:30];
    }
    
}

-(void)share{
    @autoreleasepool {
        [productView.shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:productView.shareBtn];
    }
    
}

-(void)shareAction{
    @autoreleasepool {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller addImage:productView.imageView.image];
        [self presentViewController:controller animated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.refreshBool = YES;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.refreshBool) {
        [self refresh];
    }
}

-(void)dealloc{
    productView = nil;
    hyDataBase = nil;
    self.num = nil;
    self.library = nil;
    self.array = nil;
    self.query = nil;
    self.progressView = nil;
    self.timer = nil;
    self.leftButton = nil;
    self.rightButton = nil;
    self.addButton = nil;
    arController = nil;
    self.alertView = nil;
}

@end
