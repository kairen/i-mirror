//
//  FactoryController.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/22.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "FactoryController.h"

@implementation FactoryController
CGFloat scale, rotate;

-(void)passImage:(UIImage *)image{
    self.image = image;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    @autoreleasepool {
        [super viewDidLoad];
        factoryView = [[FactoryView alloc]initWithFrame:self.view.frame];
        self.view = factoryView;
        
        [self hideTabBar];
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"選取圖片",@"橡皮擦", nil]];
        [segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
        self.navigationItem.titleView = segmentedControl;
        [segmentedControl addTarget:self action:@selector(chooseSegmented:) forControlEvents:UIControlEventValueChanged];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchScreen)];
        [tapGestureRecognizer setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:tapGestureRecognizer];
        
        factoryView.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        factoryView.backImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        factoryView.backImageView.layer.borderWidth = 5;
        factoryView.imageView.image = self.image;
        
        UIGraphicsBeginImageContext(factoryView.imageView.frame.size);
        [factoryView.imageView.image drawInRect:factoryView.imageView.bounds];
        factoryView.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [factoryView.backImageView addSubview:factoryView.imageView];
        
        [self.view addSubview:factoryView.backImageView];
        
        self.saveItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(waitStart)];
        self.navigationItem.rightBarButtonItem = self.saveItem;
        
        

    }
}

- (void)chooseSegmented:(id)sender {
    
    @autoreleasepool {
        NSLog(@"%@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]);
        
        if ([[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] isEqualToString:@"選取圖片"]) {
            self.executeString = nil;
            self.pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doScale:)];
            [factoryView.backImageView addGestureRecognizer:self.pinch];
            
            self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(doMovement:)];
            [factoryView.backImageView addGestureRecognizer:self.pan];
        }
        
        if ([[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] isEqualToString:@"橡皮擦"]) {
            self.executeString = @"execute";
            [factoryView.backImageView removeGestureRecognizer:self.pinch];
            [factoryView.backImageView removeGestureRecognizer:self.pan];
            
        }
    }
    
}


-(void)touchScreen{
    if (self.navigationController.navigationBarHidden == YES) {
        [[self navigationController]setNavigationBarHidden:NO animated:YES];
    }
    else{
        [[self navigationController]setNavigationBarHidden:YES animated:YES];
    }
}

- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO){
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else{
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    }
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else{
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    }
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)doScale:(UIPinchGestureRecognizer *)sender {
    if([sender state] == UIGestureRecognizerStateBegan) {
        scale = sender.scale;
    }
    
    scale = 1 + (sender.scale - scale);
    CGAffineTransform transform = CGAffineTransformScale(sender.view.transform, scale, scale);
    [sender.view setTransform:transform];
    
    scale = [sender scale];
}

- (void)doMovement:(UIPanGestureRecognizer *)sender {
    [sender.view setCenter:[sender locationInView:self.view]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    @autoreleasepool {
        UITouch *touch = [touches anyObject];
        
        if ([self.executeString isEqualToString:@"execute"]) {
            CGPoint currentPoint = [touch locationInView:factoryView.imageView];
            
            UIGraphicsBeginImageContext(factoryView.imageView.frame.size);
            [factoryView.imageView.image drawInRect:factoryView.imageView.bounds];
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
            
            CGContextAddArc(context, currentPoint.x, currentPoint.y, 25 , 0.0, 2*M_PI, 0);
            CGContextClip(context);
            CGContextClearRect (context, CGRectMake(currentPoint.x - 25, currentPoint.y - 25, 50 , 50));
            
            factoryView.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [factoryView.backImageView addSubview:factoryView.imageView];
            
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    @autoreleasepool {
        UITouch *touch = [touches anyObject];
        
        if ([self.executeString isEqualToString:@"execute"]) {
            CGPoint currentPoint = [touch locationInView:factoryView.imageView];
            
            UIGraphicsBeginImageContext(factoryView.imageView.frame.size);
            [factoryView.imageView.image drawInRect:factoryView.imageView.bounds];
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
            
            CGContextAddArc(context, currentPoint.x, currentPoint.y, 25 , 0.0, 2*M_PI, 0);
            CGContextClip(context);
            CGContextClearRect (context, CGRectMake(currentPoint.x - 25, currentPoint.y - 25, 50 , 50));
            
            factoryView.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [factoryView.backImageView addSubview:factoryView.imageView];
            
        }
    }
}

-(void)waitStart{
    
    @autoreleasepool {
        [[self navigationController]setNavigationBarHidden:YES animated:YES];
        self.navigationItem.titleView.userInteractionEnabled = NO;
        [factoryView.backImageView removeGestureRecognizer:self.pinch];
        [factoryView.backImageView removeGestureRecognizer:self.pan];
        self.executeString = nil;
        
        self.startView = [[UIView alloc]initWithFrame:CGRectMake(60, 80, 200, 200)];
        self.startView.backgroundColor = [UIColor blackColor];
        self.startView.layer.cornerRadius = 20.0 ;
        self.startView.alpha = 0.7 ;
        
        self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.center = CGPointMake(self.startView.bounds.size.width / 2, self.startView.bounds.size.height / 2 );
        self.indicator.color = [UIColor whiteColor];
        [self.indicator startAnimating];
        [factoryView.imageView addSubview:self.indicator];
        
        self.startLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 120, 40)];
        self.startLabel.backgroundColor = [UIColor clearColor];
        self.startLabel.text = @"處理中...";
        self.startLabel.textColor = [UIColor whiteColor];
        self.startLabel.font = [UIFont fontWithName:@"Arial" size:30] ;
        
        [self.startView addSubview:self.indicator];
        [self.startView addSubview:self.startLabel];
        [self.view addSubview:self.startView];
        
        self.progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        float theInterval = 0.5 / 9.0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:theInterval target:self selector:@selector(running) userInfo:nil repeats:YES];
    }
    
    
}

- (void)running {
    
    if (self.progressView.progress != 1.0) {
        self.progressView.progress = self.progressView.progress + 0.1;
    }
    else {
        if (self.progressView.progress == 1.0) {
            [self.startView removeFromSuperview];
            [self saveFirst];
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

-(void)saveFirst{
    
    @autoreleasepool {
        NSData *pngData = UIImagePNGRepresentation(factoryView.imageView.image);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        
        NSString *str = [NSString stringWithFormat:@"%@",factoryView.imageView.image];
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[str substringWithRange:NSMakeRange(10, 9)]]]; //Add the file name
        [pngData writeToFile:filePath atomically:YES]; //Write the file
        
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSString *composeStr = [NSString stringWithFormat:@"insert into jacket('photo') values ('%@');",[str substringWithRange:NSMakeRange(10, 9)]];
        [hyDataBase executeSQLMethod:composeStr];
        
        factoryView.imageName = [NSString stringWithFormat:@"%@",[str substringWithRange:NSMakeRange(10, 9)]] ;
        
        [self openSaveView];
    }
    
    
}

-(void)openSaveView{
    
    @autoreleasepool {
        [self.view addSubview:factoryView.saveView];
        
        NSArray *itemArray =[NSArray arrayWithObjects:@"MEN", @"WOMEN", @"KID", nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.frame = CGRectMake(60.0, 5.0, 150.0, 30.0);
        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self action:@selector(chooseOne:) forControlEvents:UIControlEventValueChanged];
        self.sexName = [itemArray objectAtIndex:0];
        [factoryView.saveView addSubview:segmentedControl];
        
        self.sortArray = [[NSArray alloc] initWithObjects:@"上衣類",@"下身類",@"家居類",@"配件", nil];
        self.firstClass = [self.sortArray objectAtIndex:0];
        
        [factoryView.sortBtn addTarget:self action:@selector(myactionSheet) forControlEvents:UIControlEventTouchDown];
        [factoryView.sortBtn setTitle:[NSString stringWithFormat:@"%@",self.firstClass] forState:UIControlStateNormal];
        [factoryView.saveView addSubview:factoryView.sortBtn];
        
        [factoryView.saveView addSubview:factoryView.sex];
        [factoryView.saveView addSubview:factoryView.sort];
        [factoryView.saveView addSubview:factoryView.name];
        [factoryView.saveView addSubview:factoryView.sign];
        [factoryView.saveView addSubview:factoryView.price];
        [factoryView.saveView addSubview:factoryView.color];
        
        factoryView.nameTxt.delegate = self;
        [factoryView.saveView addSubview:factoryView.nameTxt];
        
        factoryView.signTxt.delegate = self;
        [factoryView.saveView addSubview:factoryView.signTxt];
        
        factoryView.priceTxt.delegate = self;
        [factoryView.saveView addSubview:factoryView.priceTxt];
        
        factoryView.colorTxt.delegate = self;
        [factoryView.saveView addSubview:factoryView.colorTxt];
        
        [factoryView.saveBtn addTarget:self action:@selector(saveViewEnter) forControlEvents:UIControlEventTouchDown];
        [factoryView.saveView addSubview:factoryView.saveBtn];
        
        [factoryView.delBtn addTarget:self action:@selector(saveViewDel) forControlEvents:UIControlEventTouchDown];
        [factoryView.saveView addSubview:factoryView.delBtn];
    }
    
    
}

-(void)chooseOne:(id)sender {
    NSLog(@"%@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]);
    self.sexName = [NSString stringWithFormat:@"%@",[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]];
}

-(void)saveViewEnter{
    
    @autoreleasepool {
        if (factoryView.nameTxt.text == NULL || factoryView.signTxt.text == NULL || factoryView.priceTxt.text == NULL || factoryView.colorTxt.text ==NULL) {
            UILabel *errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 195, 150, 30)];
            errorLabel.text = @"請確實全部填寫！";
            errorLabel.textColor = [UIColor redColor];
            errorLabel.backgroundColor = [UIColor clearColor];
            [factoryView.saveView addSubview:errorLabel];
        }
        else{
            
            NSLog(@"%@",self.sexName);
            hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
            NSMutableArray *updataSex = [NSString stringWithFormat:@"update jacket set sex = '%@' where photo = '%@' ;",self.sexName,factoryView.imageName];
            NSString *StrSex = [NSString stringWithFormat:@"%@",updataSex];
            [hyDataBase executeSQLMethod:StrSex];
            
            hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
            NSMutableArray *updataSort = [NSString stringWithFormat:@"update jacket set class_1 = '%@' where photo = '%@' ;",self.firstClass,factoryView.imageName];
            NSString *StrSort = [NSString stringWithFormat:@"%@",updataSort];
            [hyDataBase executeSQLMethod:StrSort];
            
            hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
            NSMutableArray *updataName = [NSString stringWithFormat:@"update jacket set name = '%@' where photo = '%@' ;",factoryView.nameTxt.text,factoryView.imageName];
            NSString *StrName = [NSString stringWithFormat:@"%@",updataName];
            [hyDataBase executeSQLMethod:StrName];
            
            hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
            NSMutableArray *updataSign = [NSString stringWithFormat:@"update jacket set id = '%@' where photo = '%@' ;",factoryView.signTxt.text,factoryView.imageName];
            NSString *StrSign = [NSString stringWithFormat:@"%@",updataSign];
            [hyDataBase executeSQLMethod:StrSign];
            
            hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
            NSMutableArray *updataPrice = [NSString stringWithFormat:@"update jacket set price = '%@' where photo = '%@' ;",factoryView.priceTxt.text,factoryView.imageName];
            NSString *StrPrice = [NSString stringWithFormat:@"%@",updataPrice];
            [hyDataBase executeSQLMethod:StrPrice];
            
            hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
            NSMutableArray *updataColor = [NSString stringWithFormat:@"update jacket set color = '%@' where photo = '%@' ;",factoryView.colorTxt.text,factoryView.imageName];
            NSString *StrColor = [NSString stringWithFormat:@"%@",updataColor];
            [hyDataBase executeSQLMethod:StrColor];
            
            
            [self showAlertView];
        }

    }
    
    
}

-(void)showAlertView{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"儲存成功"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"返回"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    alertView.delegate = self ;
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

-(void)saveViewDel{
    [factoryView.saveView removeFromSuperview];
    self.navigationItem.titleView.userInteractionEnabled = YES;
}

-(void)myactionSheet{
    
    @autoreleasepool {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
        
        [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
        
        
        CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        pickerView.showsSelectionIndicator = YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        
        [self.actionSheet addSubview:pickerView];
        
        UISegmentedControl *button = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"確定"]];
        button.momentary = YES;
        button.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
        button.segmentedControlStyle = UISegmentedControlStyleBar;
        button.tintColor = [UIColor blackColor];
        
        [button addTarget:self action:@selector(closePicker) forControlEvents:UIControlEventValueChanged];
        [self.actionSheet addSubview:button];
        
        [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
        
        [self.actionSheet setBounds:CGRectMake(0, 0, 320, 480)];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return [self.sortArray count];
            break;
        default:
            return 0;
            break;
    }
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return [self.sortArray objectAtIndex:row];
            break;
        default:
            return @"Error";
            break;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.firstClass = [NSString stringWithFormat:@"%@",[self.sortArray objectAtIndex:row]];
    [factoryView.sortBtn setTitle:[NSString stringWithFormat:@"%@",self.firstClass] forState:UIControlStateNormal];
}

-(void)closePicker{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showTabBar];
    [[self navigationController]setNavigationBarHidden:NO animated:YES];
}

-(void)dealloc{
    factoryView = nil;
}

@end
