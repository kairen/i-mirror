//
//  BuyClothesController.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/5/20.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "BuyClothesController.h"

@implementation BuyClothesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

    self.array = [[NSArray alloc]initWithObjects:@"Hana*少女衣著",@"廠商二",@"廠商三",@"廠商四",@"廠商五", nil];
    self.mutableArray = [[NSMutableArray alloc]initWithObjects:self.array, nil];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.mutableArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mutableArray objectAtIndex:section]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.mutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            buyMenu = [[BuyMenu alloc]init];
            [self.navigationController pushViewController:buyMenu animated:YES];
            break;
            
        default:
            break;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
