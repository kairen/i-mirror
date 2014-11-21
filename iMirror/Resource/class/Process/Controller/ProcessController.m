//
//  ProcessController.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/19.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "ProcessController.h"

@implementation ProcessController

- (void)viewDidLoad
{
    [super viewDidLoad];
	processView = [[ProcessView alloc]initWithFrame:self.view.frame];
    self.view = processView;
    
    self.title = @"選擇方式";
    
    [self.view addSubview:processView.minorView];
    
    [processView.cameraBtn addTarget:self action:@selector(camera) forControlEvents:UIControlEventTouchDown];
    [processView.photoBtn addTarget:self action:@selector(photos) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:processView.cameraBtn];
    [self.view addSubview:processView.photoBtn];
    [self.view addSubview:processView.webBtn];
    
    self.trackedViewName = @"Process Screen";

}

-(void)camera{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

-(void)photos{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    @autoreleasepool {
        UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        factoryController = [[FactoryController alloc]init];
        [factoryController passImage:image];
        [self.navigationController pushViewController:factoryController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    processView = nil;
    self.imagePicker = nil;
}

@end
