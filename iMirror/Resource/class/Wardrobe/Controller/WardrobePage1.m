//
//  WardrobePage1.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "WardrobePage1.h"

@interface WardrobePage1 ()

@end

@implementation WardrobePage1

- (void)viewDidLoad
{
    [super viewDidLoad];
	page1 = [[Page1 alloc]initWithFrame:self.view.frame];
    self.view = page1;
    
    [self.view addSubview:page1.minorView];
    [self.view addSubview:page1.WardrobeImageView];
    
    [page1.men addTarget:self action:@selector(goToMenPage1) forControlEvents:UIControlEventTouchDown];
    [page1.women addTarget:self action:@selector(goToWomenPage1) forControlEvents:UIControlEventTouchDown];
    [page1.kids addTarget:self action:@selector(goToKidsPage1) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:page1.men];
    [self.view addSubview:page1.women];
    [self.view addSubview:page1.kids];
    
    self.trackedViewName = @"Wardrobe Screen";

}

-(void)goToMenPage1{
    wardrobepage2 = [[WardrobePage2 alloc]init];
    [wardrobepage2 passValue:@"男士區"];
    [self.navigationController pushViewController:wardrobepage2 animated:YES];
}

-(void)goToWomenPage1{
    wardrobepage2 = [[WardrobePage2 alloc]init];
    [wardrobepage2 passValue:@"女士區"];
    [self.navigationController pushViewController:wardrobepage2 animated:YES];
}

-(void)goToKidsPage1{
    wardrobepage2 = [[WardrobePage2 alloc]init];
    [wardrobepage2 passValue:@"兒童區"];
    [self.navigationController pushViewController:wardrobepage2 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    page1 = nil;
    wardrobepage2 = nil;
}

@end
