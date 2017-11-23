//
//  PhotoViewController.m
//  Aproject
// http://blog.csdn.net/shenjie12345678/article/details/44152605线程多张图片
//  Created by slcf888 on 2017/11/21.
//  Copyright © 2017年 slcf888. All rights reserved.
//  data是数据 date是时间


#import "PhotoViewController.h"
#define KURL @"http://upload-images.jianshu.io/upload_images/3217231-2710efdfc076a204.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/640"
@interface PhotoViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageViewTwo;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    _imageView.backgroundColor =[UIColor yellowColor];
    [self.view addSubview:_imageView];
    [self Two];
    // Do any additional setup after loading the view.
}
- (void)Two{
    _imageViewTwo =[[UIImageView alloc]initWithFrame:CGRectMake(50, 400, 200, 200)];
    _imageViewTwo.backgroundColor =[UIColor greenColor];
    [self.view addSubview:_imageViewTwo];
    NSThread *thread =[[NSThread alloc]initWithTarget:self selector:@selector(down:) object:KURL];
    [thread start];
}
- (void)down:(NSString *)URL
{
    NSData *data =[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:URL]];
    UIImage *image =[[UIImage alloc]initWithData:data];
    if (image ==nil) {
        
    }else{
        [self performSelectorOnMainThread:@selector(updataUI:) withObject:image waitUntilDone:nil];
    }
}
- (void)updataUI:(UIImage *)image
{
    self.imageViewTwo.image =image;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"xxxxxx");
         NSURL *url =[NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/7618722-73a8e3d650b79256.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1080/q/50"];
        NSData *data =[NSData dataWithContentsOfURL:url];
        UIImage *image =[UIImage imageWithData:data];
        //回到主线程
        [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    });
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
