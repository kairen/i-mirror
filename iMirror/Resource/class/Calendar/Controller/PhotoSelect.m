//
//  PhotoSelect.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/3.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "PhotoSelect.h"

@implementation PhotoSelect

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

-(void)passImage:(NSString *)Str{
    
    self.imageName = Str;
    
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",Str]]]];
    self.imageView.frame = CGRectMake(40, 20, 240, 320);
    [self.view addSubview:self.imageView];
    
    if (Str != nil) {
        self.navigationItem.rightBarButtonItem = nil;
        [self creatEditButton];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"當天衣著";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self creatAddButton];
}

-(void)creatAddButton{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStyleBordered target:self action:@selector(creatPhoto)];
    self.navigationItem.rightBarButtonItem = rightButton ;
}

- (void) returnString:(NSString *)str{
    
    if (str == NULL) {
        [self.imageView removeFromSuperview];
        [self creatAddButton];
    }
    
    self.imageName = str;
    
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@",str]]]];
    self.imageView.frame = CGRectMake(40, 20, 240, 320);
    [self.view addSubview:self.imageView];
    
    if (str != nil) {
        self.navigationItem.rightBarButtonItem = nil;
        [self creatEditButton];
    }
}

-(void)creatEditButton{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"編輯" style:UIBarButtonItemStyleBordered target:self action:@selector(sheet)];
    self.navigationItem.rightBarButtonItem = rightButton ;
}

#pragma mark - 產生ActionSheet

-(void)sheet{
    self.actionSheet = [[UIActionSheet alloc]initWithTitle:@"選單"
                                                            delegate:self
                                                   cancelButtonTitle:@"返回"
                                              destructiveButtonTitle:@"刪除"
                                                   otherButtonTitles:@"更改",
                                  nil];
    [self.actionSheet setTag:0];
    [self.actionSheet showFromTabBar:self.tabBarController.tabBar];
}

#pragma mark - 判斷ActionSheet按鈕事件

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 0) {
        switch (buttonIndex) {
            case 0:
                [self deleteImageView];
                break;
            case 1:
                [self creatPhoto];
                break;
            case 2:
                break;
            default:
                break;
        }
    }
}

-(void)creatPhoto{
    photoChoose = [[PhotoChoose alloc]init];
    photoChoose.delegate = self;
    [self.navigationController pushViewController:photoChoose animated:YES];
}

-(void)deleteImageView{
    [self.imageView removeFromSuperview];
    self.imageView.image = nil;
    self.imageView = nil;
    self.imageName = nil;
    [self creatAddButton];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.delegate returnString:self.imageName];
}

-(void)dealloc{
    hyDataBase = nil;
    self.imageView = nil;
    self.imageName = nil;
    self.actionSheet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
