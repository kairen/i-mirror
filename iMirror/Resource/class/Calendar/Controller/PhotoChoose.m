//
//  PhotoChoose.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "PhotoChoose.h"
#import <QuartzCore/QuartzCore.h>


@implementation PhotoChoose

-(void)selectDataBase{
    hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
    self.library = [NSString stringWithFormat:@"%@",self.query];
    self.array =[hyDataBase executeSelect:self.library];
    self.num = [NSString stringWithFormat:@"%@",self.array[0]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.title = @"選擇圖片" ;
    
    self.query = @"select count(*) from Outfit;";
    [self selectDataBase];
    
    if ([self.num intValue] == 0) {
        self.txtLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 160, 240, 50)];
        self.txtLabel.text = @"目前沒有任何圖片";
        self.txtLabel.textColor = [UIColor blueColor];
        self.txtLabel.font = [UIFont fontWithName:@"Arial" size:30];
        self.txtLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.txtLabel];
    }
    
    else{
        [self creatRightButton];
        [self waitStart];
    }

}

-(void)creatRightButton{
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"選擇" style:UIBarButtonItemStylePlain target:self action:@selector(returnImage)];
    [self.navigationItem setRightBarButtonItem:self.rightButton ] ;
}

-(void)returnImage{
    [self.delegate returnString:self.imageName];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatScrollView{
    
    self.leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, [[UIScreen mainScreen] bounds].size.height - 130)];
    self.leftView.image = [UIImage imageNamed:@"Product_leftView.png"];
    [self.view addSubview:self.leftView];
    
    self.query = @"select count(*) from Outfit;";
    [self selectDataBase];
    
    int pageCount = [self.num intValue];
    
    self.imageNum = [[NSNumber alloc]initWithInt:pageCount];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 10, 72, [[UIScreen mainScreen] bounds].size.height - 140)];
    self.scrollView.contentSize = CGSizeMake(72, 100*pageCount);
    self.scrollView.pagingEnabled = NO;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.delegate = self ;
    self.scrollView.showsHorizontalScrollIndicator = NO ;
    self.scrollView.showsVerticalScrollIndicator = NO ;
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    //Add our scroll view to the main window's view hierarchy
    [self.view addSubview:self.scrollView];
    
    //Flash the scroll view indicators when the window is visible
    [self.scrollView flashScrollIndicators];
    
}

-(void)waitStart{
    
    self.startView = [[UIView alloc]initWithFrame:CGRectMake(60, 80, 200, 200)];
    self.startView.backgroundColor = [UIColor blackColor];
    self.startView.layer.cornerRadius = 20.0 ;
    self.startView.alpha = 0.7 ;
    
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.center = CGPointMake(self.startView.bounds.size.width / 2, self.startView.bounds.size.height / 2 );
    self.indicator.color = [UIColor whiteColor];
    [self.indicator startAnimating];
    [self.imageView addSubview:self.indicator];
    
    self.startLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 120, 40)];
    self.startLabel.backgroundColor = [UIColor clearColor];
    self.startLabel.text = @"請稍候...";
    self.startLabel.textColor = [UIColor whiteColor];
    self.startLabel.font = [UIFont fontWithName:@"Arial" size:30] ;
    
    [self.startView addSubview:self.indicator];
    [self.startView addSubview:self.startLabel];
    [self.view addSubview:self.startView];
    
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
        
        self.query = @"select count(*) from Outfit;";
        [self selectDataBase];
        
        if ([self.num intValue] == 0) {
            [self.startView removeFromSuperview];
            
            [self.timer invalidate];
            self.timer = nil;
            return;
        }
        else{
            [self creatScrollView];
            [self loadPhoto];
            [self.startView removeFromSuperview];
            self.scrollView.scrollEnabled = YES ;
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

-(NSString*) returnDocumentsForImageName:(NSString*)imageName
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
}

-(void)loadPhoto{
    int i =0 ;
    
    for (i = 0; i < [self.imageNum intValue]; i++) {
        
        self.query = @"select photo from Outfit;";
        [self selectDataBase];
        
        self.imageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.imageButton.frame = CGRectMake(0, 0, 72, 90);
        [self.imageButton setBackgroundImage:[UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",self.array[i]]]] forState:UIControlStateNormal];
        [self.imageButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.imageButton setTag: i];
        CGRect f = CGRectMake(0, i*100, 72, 90);
        UIView *view = [[UIView alloc] initWithFrame:f];
        
        [view addSubview:self.imageButton];
        [self.scrollView addSubview:view];
    }
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2) - 50, 15, 190, 270)];
    self.imageView.image = [UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",self.array[0]]]];
    self.imageName = [NSString stringWithFormat:@"%@",self.array[0]];
    [self.view addSubview:self.imageView];
    
    self.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Product_rightView.png"]];
    self.rightView.frame = CGRectMake((self.view.frame.size.width/2) - 60, 10, 210, 280);
    [self.view addSubview:self.rightView];
    
}

-(void)buttonClicked:(id)sender{
    [self.imageView removeFromSuperview];
    [self.rightView removeFromSuperview];
    UIButton* btn = (UIButton*)sender;
    
    int x = 0;
    
    int y = [self.imageNum intValue];
    
    while ((x < y)) {
        
        if (x == btn.tag) {
            self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2) - 50, 15, 190, 270)];
            self.imageView.image = [UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",self.array[x]]]];
            self.imageName = [NSString stringWithFormat:@"%@",self.array[x]];
            [self.view addSubview:self.imageView];
            
            self.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Product_rightView.png"]];
            self.rightView.frame = CGRectMake((self.view.frame.size.width/2) - 60, 10, 210, 280);
            [self.view addSubview:self.rightView];

        }
        x++;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.delegate returnString:self.imageName];
}

-(void)dealloc{
    self.scrollView = nil;
    self.imageView = nil;
    self.imageNum = nil;
    self.num = nil;
    self.library = nil;
    self.array = nil;
    self.query = nil;
    self.indicator = nil;
    self.progressView = nil;
    self.timer = nil;
    self.startView = nil;
    self.startLabel = nil;
    self.imageButton = nil;
    self.rightButton = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
