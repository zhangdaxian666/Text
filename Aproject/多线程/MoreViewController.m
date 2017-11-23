//https://git-scm.com/book/zh/v2/起步-初次运行-Git-前的配置
//  MoreViewController.m
//  Aproject     http://www.jspatch.com/Tools/convertor
// cd 到项目 git clone git地址。  add添加分支    最后右键chekout切换
//  Created by slcf888 on 2017/11/22.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "MoreViewController.h"
#import "ImageData.h"
#define ROW_HEIGHT 100
#define ROW_WIDTH 100
//#define CELL_SPACING 10
@interface MoreViewController ()
{
    NSMutableArray *_imageViews;
    NSMutableArray *_threads;//fix
    NSMutableArray *_imageNames;//
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self layoutUI];
    // Do any additional setup after loading the view.
}
- (void)layoutUI
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 600)];
    //创建多个控件显示
    _imageViews =[NSMutableArray array];
    for (int r=0; r<5; r++) {
        for (int c=0; c<3; c++) {
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*10), r*ROW_HEIGHT+(r*10), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode =UIViewContentModeScaleAspectFit;
            imageView.backgroundColor =[UIColor yellowColor];
            [view addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
    [self.view addSubview:view];
    UIButton *button =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame =CGRectMake(50, 700, 100, 25);
    [button setTitle:@"加载开始" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton *buttonstop =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonstop.frame =CGRectMake(160, 700, 100, 25);
    [buttonstop setTitle:@"停止加载" forState:UIControlStateNormal];
    [buttonstop addTarget:self action:@selector(stopLoadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonstop];
    
}
#pragma 将图片显示
- (void)updateImage:(ImageData*)imageData{
    UIImage *image =[UIImage imageWithData:imageData.data];
    UIImageView *imageView =_imageViews[imageData.index];
    imageView.image =image;
}
#pragma 请求图片数据
- (NSData *)requestData:(NSInteger)index
{
    //http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg
    @autoreleasepool {
        NSURL *url =[NSURL URLWithString:@"http://img.tuku.cn/file_thumb/201409/m2014090901231032.jpg"];
        NSData *data =[NSData dataWithContentsOfURL:url];
        return data;
    }
}
#pragma 加载图片  NSInteger 换的int
- (void)loadImage:(NSNumber *)index{
    //获取当前线程
//    NSLog(@"%@",[NSThread currentThread]);
    NSInteger i=[index integerValue];
    NSData *data =[self requestData:i];

    ImageData *imageData =[[ImageData alloc]init];
    imageData.index =i;
    imageData.data =data;
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:imageData waitUntilDone:YES];
}
#pragma 多线程下载
- (void)loadImageWithMultiThread{
    //创建多个线程填充图片
    for (int i=0; i<5 *3; i++) {
        NSThread *thread =[[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
        thread.name =[NSString stringWithFormat:@"myThread%i",i];
        [thread start];
    }
}
#pragma 停止加载图片
- (void)stopLoadImage{
    [NSThread exit];//  取消当前线程
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
