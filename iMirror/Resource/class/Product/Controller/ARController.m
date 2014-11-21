//
//  ARController.m
//  iMirror
//
//  Created by Apple MacBook Pro 17" on 13/3/10.
//  Copyright (c) 2013年 brian. All rights reserved.
//

#import "ARController.h"
CGFloat scale, rotate;
@interface ARController ()

@end

@implementation ARController

-(void)selectDataBase{
    @autoreleasepool {
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        self.library = [NSString stringWithFormat:@"%@",self.query];
        self.array =[hyDataBase executeSelect:self.library];
        self.num = [NSString stringWithFormat:@"%@",self.array[0]];
    }
}

-(NSString*) returnDocumentsForImageName:(NSString*)imageName
{
    @autoreleasepool {
        return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    }
}

-(id) initWithSourceType:(UIImagePickerControllerSourceType)type
{
    @autoreleasepool {
        self = [super init];
        if(self)
        {
            self.sourceType = type;
            self.delegate = self;
            //        self.allowsEditing = YES ;
            
        }
        return self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self leftView];
}

-(void)passValue:(NSString *)text{
    self.passText = text;
    NSLog(@"%@",self.passText);
}
//使用代理之後才會出現的內建函式
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    @autoreleasepool {
        //取得影像
        UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        self.imageView = [[UIImageView alloc]initWithImage:image];
        self.imageView.frame = CGRectMake(0, 0, 320, 430);
        [self.view addSubview:self.imageView];
        [self.imageView addSubview:self.backImageView];
        
        NSLog(@"Save");
        //截取畫面 並 裁切
        UIWindow *screenWindows = [[UIApplication sharedApplication] keyWindow];
        CGSize size = CGSizeMake(screenWindows.frame.size.width, screenWindows.frame.size.height);
        UIGraphicsBeginImageContext(size);
        [screenWindows.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //---------------------------------------cutting------------------------------------------//
        
        //設定剪裁影像的位置與大小
        CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], CGRectMake(0, 0, viewImage.size.width, viewImage.size.height-50));
        //剪裁影像
        self.copiedImage = [UIImage imageWithCGImage:imageRef];
        
        NSData *pngData = UIImagePNGRepresentation(self.copiedImage);
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        
        NSString *str = [NSString stringWithFormat:@"%@",self.copiedImage];
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[str substringWithRange:NSMakeRange(10, 9)]]]; //Add the file name
        [pngData writeToFile:filePath atomically:YES]; //Write the file
        
        // insert database
        hyDataBase = [[HYDataBase alloc]hyDataBaseWithDataBasePath:@"WardrobeDB.sqlite"];
        NSString *composeStr = [NSString stringWithFormat:@"insert into Outfit('photo') values ('%@.png');",[str substringWithRange:NSMakeRange(10, 9)]];
        [hyDataBase executeSQLMethod:composeStr];
        
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        if (appDelegate.photoInPhone) {
            UIImageWriteToSavedPhotosAlbum(self.copiedImage, self,nil, nil);
        }
        
        //----------------------------------------------------------------------------------------//
        
        //clear view
        for(UIView *reView in self.view.subviews)
        {
            [reView removeFromSuperview];
        }
        //add image
        self.imageView.image = self.copiedImage;
        [self.view addSubview:self.imageView];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)leftView{
    
    @autoreleasepool {
        self.sideView = [[UIView alloc]initWithFrame:CGRectMake(-130, 80, 170, 300)];
        self.sideView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.sideView];
        
        self.startBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        self.startBtn.frame = CGRectMake(120, 120, 50, 50);
        [self.startBtn addTarget:self action:@selector(startBtnBegin) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.startBtn];
        
        //    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 30)];
        //    self.titleLabel.backgroundColor = [UIColor clearColor];
        //    self.titleLabel.text = @"插入圖片";
        //    [self.sideView addSubview:self.titleLabel];
        
        NSArray *itemArray =[NSArray arrayWithObjects:@"男士", @"女士", @"兒童", nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.frame = CGRectMake(5.0, 5.0, 125.0, 30.0);
        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self action:@selector(chooseOne:) forControlEvents:UIControlEventValueChanged];
        self.sexName = @"MEN";
        [self.sideView addSubview:segmentedControl];
        
        self.btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btn1.frame = CGRectMake(5, 40, 60, 30);
        [self.btn1 setTitle:@"上衣類" forState:UIControlStateNormal];
        [self.btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.btn1];
        
        self.btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btn2.frame = CGRectMake(70, 40, 60, 30);
        [self.btn2 setTitle:@"下身類" forState:UIControlStateNormal];
        [self.btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.btn2];
        
        self.btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btn3.frame = CGRectMake(5, 80, 60, 30);
        [self.btn3 setTitle:@"家居類" forState:UIControlStateNormal];
        [self.btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.btn3];
        
        self.btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btn4.frame = CGRectMake(70, 80, 60, 30);
        [self.btn4 setTitle:@"配件" forState:UIControlStateNormal];
        [self.btn4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.btn4];
        
        self.secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 120, 100, 30)];
        self.secondLabel.backgroundColor = [UIColor clearColor];
        self.secondLabel.text = @"圖片控制";
        [self.sideView addSubview:self.secondLabel];
        
        self.zoomLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 160, 100, 30)];
        self.zoomLabel.backgroundColor = [UIColor clearColor];
        self.zoomLabel.text = @"縮放：";
        [self.sideView addSubview:self.zoomLabel];
        
        self.moveLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 210, 100, 30)];
        self.moveLabel.backgroundColor = [UIColor clearColor];
        self.moveLabel.text = @"拖曳：";
        [self.sideView addSubview:self.moveLabel];
        
        self.zoomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.zoomBtn.frame = CGRectMake(55, 160, 40, 30);
        [self.zoomBtn setTitle:@"關閉" forState:UIControlStateNormal];
        [self.zoomBtn addTarget:self action:@selector(zoomImageButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.zoomBtn];
        self.zoomBtn.enabled = NO;
        
        self.moveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.moveBtn.frame = CGRectMake(55, 210, 40, 30);
        [self.moveBtn setTitle:@"關閉" forState:UIControlStateNormal];
        [self.moveBtn addTarget:self action:@selector(moveImageButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.moveBtn];
        self.moveBtn.enabled = NO;
        
        self.discernZoom = [[UIView alloc]initWithFrame:CGRectMake(105, 163, 20, 20)];
        self.discernZoom.backgroundColor = [UIColor redColor];
        self.discernZoom.layer.cornerRadius = 10;
        [self.sideView addSubview:self.discernZoom];
        
        self.discernMove = [[UIView alloc]initWithFrame:CGRectMake(105, 213, 20, 20)];
        self.discernMove.backgroundColor = [UIColor redColor];
        self.discernMove.layer.cornerRadius = 10;
        [self.sideView addSubview:self.discernMove];
        
        self.clearBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.clearBtn.frame = CGRectMake(5, 250, 80, 30);
        [self.clearBtn setTitle:@"清除圖片" forState:UIControlStateNormal];
        [self.clearBtn addTarget:self action:@selector(clearImage) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.clearBtn];
        self.clearBtn.enabled = NO;
    }
    
}

-(void)chooseOne:(id)sender {
    
    @autoreleasepool {
        if ([[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] isEqualToString:@"男士"]) {
            self.sexName = @"MEN";
        }
        if ([[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] isEqualToString:@"女士"]) {
            self.sexName = @"WOMEN";
        }
        if ([[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]] isEqualToString:@"兒童"]) {
            self.sexName = @"KID";
        }

    }
}

-(void)buttonClicked:(id)sender{
    
    @autoreleasepool {
        UIButton* btn = (UIButton*)sender;
        
        self.query = [NSString stringWithFormat: @"select count(*) from jacket where class_1 = '%@' and sex = '%@';",btn.titleLabel.text,self.sexName];
        [self selectDataBase];
        
        int pageCount = [self.num intValue] ;
        if (pageCount == 0) {
            
        }
        else{
            self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
            self.scrollView.contentSize = CGSizeMake(240*pageCount, 240);
            self.scrollView.pagingEnabled = YES;
            self.scrollView.scrollEnabled = YES;
            self.scrollView.delegate = self ;
            self.scrollView.showsHorizontalScrollIndicator = NO ;
            self.scrollView.backgroundColor = [UIColor clearColor];
            
            self.imageView = nil;
            
            self.backImageView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 240, 240)];
            self.backImageView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:self.backImageView];
            
            for (int i = 0; i < pageCount; i++) {
                self.query = nil;
                self.query = [NSString stringWithFormat:@"select photo from jacket where class_1 = '%@' and sex = '%@';" ,btn.titleLabel.text,self.sexName];
                [self selectDataBase];
                self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 240)];
                self.imageView.image = [UIImage imageWithContentsOfFile:[self returnDocumentsForImageName:[NSString stringWithFormat:@"%@.png",self.array[i]]]];
                if (self.imageView.image == NULL ) {
                    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.array[i]]];
                }
                CGRect f = CGRectMake(i*240, 0, 240,240);
                UIView *view = [[UIView alloc] initWithFrame:f];
                
                [view addSubview:self.imageView];
                [self.scrollView addSubview:view];
            }
            
            [self.backImageView addSubview:self.scrollView];
            [self.sideView removeFromSuperview];
            [self.view addSubview:self.sideView];
            [self.scrollView flashScrollIndicators];
            [self startBtnEnd];
            
            self.clearBtn.enabled = YES;
            self.zoomBtn.enabled = YES;
            self.moveBtn.enabled = YES;
            self.btn1.enabled = NO;
            self.btn2.enabled = NO;
            self.btn3.enabled = NO;
            self.btn4.enabled = NO;
        }
    }
    
}

-(void)startBtnBegin{
    
    @autoreleasepool {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        
        //設定動畫開始時的狀態為目前畫面上的樣子
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.sideView.frame = CGRectMake(0, self.sideView.frame.origin.y, 170, 300);
        self.sideView.backgroundColor = [UIColor whiteColor];
        self.sideView.alpha = 0.8;
        [UIView commitAnimations];
        
        [self.startBtn removeFromSuperview];
        self.startBtn = nil;
        
        self.endBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        self.endBtn.frame = CGRectMake(120, 120, 50, 50);
        [self.endBtn.layer setTransform:CATransform3DMakeRotation(3.142, 0.0, 0.0, 1.0)];
        [self.endBtn addTarget:self action:@selector(startBtnEnd) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.endBtn];
    }
    

}

-(void)startBtnEnd{
    
    @autoreleasepool {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        
        //設定動畫開始時的狀態為目前畫面上的樣子
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.sideView.frame = CGRectMake(-130, self.sideView.frame.origin.y, 170, 300);
        self.sideView.backgroundColor = [UIColor clearColor];
        [UIView commitAnimations];
        
        [self.endBtn removeFromSuperview];
        self.endBtn = nil;
        
        self.startBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        self.startBtn.frame = CGRectMake(120, 120, 50, 50);
        [self.startBtn addTarget:self action:@selector(startBtnBegin) forControlEvents:UIControlEventTouchDown];
        [self.sideView addSubview:self.startBtn];
    }
    

}

-(void)zoomImageButtonClicked:(id)sender{
    
    @autoreleasepool {
        UIButton* btn = (UIButton*)sender;
        
        if ([btn.titleLabel.text isEqualToString:@"關閉"]){
            //設定所要偵測的UIView與對應的函式
            self.Pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doScale:)];
            //將辨識的機制加入
            [self.backImageView addGestureRecognizer:self.Pinch];
            [self.zoomBtn setTitle:@"開啟" forState:UIControlStateNormal];
            self.scrollView.scrollEnabled = NO;
            self.discernZoom.backgroundColor = [UIColor greenColor];
            return;
        }
        else if([btn.titleLabel.text isEqualToString:@"開啟"]){
            [self.zoomBtn setTitle:@"關閉" forState:UIControlStateNormal];
            [self.backImageView removeGestureRecognizer:self.Pinch];
            self.scrollView.scrollEnabled = YES;
            self.discernZoom.backgroundColor = [UIColor redColor];
            return;
        }
    }
    

}

-(void)moveImageButtonClicked:(id)sender{
    
    @autoreleasepool {
        UIButton* btn = (UIButton*)sender;
        if ([btn.titleLabel.text isEqualToString:@"關閉"]) {
            self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(doMovement:)];
            [self.backImageView addGestureRecognizer:self.pan];
            [self.moveBtn setTitle:@"開啟" forState:UIControlStateNormal];
            self.scrollView.scrollEnabled = NO;
            self.discernMove.backgroundColor = [UIColor greenColor];
            return;
        }
        else if([btn.titleLabel.text isEqualToString:@"開啟"]){
            [self.moveBtn setTitle:@"關閉" forState:UIControlStateNormal];
            [self.backImageView removeGestureRecognizer:self.pan];
            self.scrollView.scrollEnabled = YES;
            self.discernMove.backgroundColor = [UIColor redColor];
            return;
        }
        
    }
   
}

-(void)clearImage{
    
    @autoreleasepool {
        [self.imageView removeFromSuperview];
        [self.backImageView removeFromSuperview];
        [self.scrollView removeFromSuperview];
        self.clearBtn.enabled = NO;
        self.zoomBtn.enabled = NO;
        self.moveBtn.enabled = NO;
        self.btn1.enabled = YES;
        self.btn2.enabled = YES;
        self.btn3.enabled = YES;
        self.btn4.enabled = YES;
    }
    
}

- (void)doScale:(UIPinchGestureRecognizer *)sender {
    
    @autoreleasepool {
        if([sender state] == UIGestureRecognizerStateBegan) {
            scale = sender.scale;
        }
        
        scale = 1 + (sender.scale - scale);
        CGAffineTransform transform = CGAffineTransformScale(sender.view.transform, scale, scale);
        [sender.view setTransform:transform];
        
        scale = [sender scale];
    }
    
}

- (void)doMovement:(UIPanGestureRecognizer *)sender {
    
    @autoreleasepool {
        [sender.view setCenter:[sender locationInView:self.view]];
    }
}

-(void)dealloc{
    self.mediaType = nil;
    self.passText = nil;
    self.copiedImage = nil;
    self.imageView = nil;
    self.scrollView = nil;
    self.num = nil;
    self.library = nil;
    self.array = nil;
    self.query= nil ;
    self.sideView = nil;
    self.startBtn = nil;
    self.endBtn = nil;
    self.pan = nil;
    self.Pinch = nil;
    self.clearBtn = nil;
    self.zoomBtn = nil;
    self.moveBtn = nil;
    self.btn1 = nil;
    self.btn2 = nil;
    self.btn3 = nil;
    self.btn4 = nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
