//
//  InstallController.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/19.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "InstallController.h"

@interface InstallController ()

@end

@implementation InstallController

- (void)viewDidLoad
{
    [super viewDidLoad];
	installView = [[InstallView alloc]initWithFrame:self.view.frame];
    self.view = installView;
        
    installView.tableView.dataSource = self ;
    installView.tableView.delegate = self ;
    
    self.type1 = [[NSArray alloc]initWithObjects:@"相機",@"廣告", nil ];
    self.type2 = [[NSArray alloc]initWithObjects:@"關於我們", nil];
    self.allType = [[NSMutableArray alloc]initWithObjects:self.type1,self.type2, nil];
    
    self.trackedViewName = @"Install Screen";

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
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.imageView.image = [UIImage imageNamed:@"Install_camera.png"];
                self.switchButton = [[UISwitch alloc] initWithFrame:CGRectZero];
                self.switchButton.on = YES;
                [self.switchButton addTarget:self action:@selector(chick_Switch:) forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = self.switchButton;
                
                break;
            case 1:
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.imageView.image = [UIImage imageNamed:@"Install_ad.png"];
                self.switchAd = [[UISwitch alloc] initWithFrame:CGRectZero];
                self.switchAd.on = YES;
                [self.switchAd addTarget:self action:@selector(ad_Switch:) forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = self.switchAd;
                break;
            case 2:
                cell.accessoryView = installView.sortLabel;
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"Install_us.png"];
                break;
                
            default:
                break;
        }
    }
    
    cell.textLabel.text = [[self.allType objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"軟體設定";
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
                
                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                break;
                
            default:
                break;
        }
    }
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
}

-(void)chick_Switch:(id)sender
{
    UISwitch *switchView = (UISwitch *)sender;
    
    
    if ([switchView isOn])  {
        AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate.photoInPhone = YES;
    }
    else {
        AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate.photoInPhone = NO;
    }
}

-(void)ad_Switch:(id)sender{
    UISwitch *switchView = (UISwitch *)sender;

    if ([switchView isOn])  {
        AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate.adInPhone = YES;
    }
    else {
        AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate.adInPhone = NO;
    }

    
}

-(void)dealloc{
    self.type1 = nil;
    self.type2 = nil;
    self.allType = nil ;
    self.switchButton = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
