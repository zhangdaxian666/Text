//
//  ViewController.m
//  Aproject
//  http://www.jb51.net/article/105897.htm//提示框
//  Created by slcf888 on 2017/11/20.
//  Copyright © 2017年 slcf888. All rights reserved.
//  http://blog.csdn.net/icandyss/article/details/50298877  label
//  http://www.cocoachina.com/ios/20171127/21331.html tableview的介绍
#import "ViewController.h"
#import "XianChengVC.h"
@interface ViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) NSMutableArray<NSLayoutConstraint *> *array;
@property (nonatomic ,strong) UISlider *videoSlider;
@property (nonatomic ,strong) NSMutableArray<NSLayoutConstraint *> *sliderArray;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self initVideoView];
    UILabel *mylabel =[[UILabel alloc]initWithFrame:CGRectMake(40, 200, 200, 100)];
    [self.view addSubview:mylabel];
    NSString *text =@"标签文本10086";
    //设置标签文本
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    // 获取标红的位置和长度
   //  NSRange range = [result rangeOfString:keyword];
    //设置标签文本属性
    [attributeString setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(4, 3)];
    mylabel.attributedText = attributeString; //显示
    
    [self TextLabel];//改变字符串的颜色
    [self TextString];//截取字符串 and 匹配字符串 or 分隔字符串 but 字符串分割
}
- (void)TextLabel
{//改变字符串的颜色
    UILabel *noteLabel =[[UILabel alloc]init];
    noteLabel.frame =CGRectMake(40, 300, 300, 100);
    noteLabel.textColor =[UIColor blackColor];
    noteLabel.numberOfLines =2;
    
    NSMutableAttributedString *noteStr =[[NSMutableAttributedString alloc]initWithString:@"点击注册按钮，即表示你已同意隐私条款和服务协议"];
    NSRange redRange =NSMakeRange([[noteStr string] rangeOfString:@"注册"].location,[[noteStr string] rangeOfString:@"注册"].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    NSRange redRangeTwo =NSMakeRange([[noteStr string] rangeOfString:@"同意"].location, [[noteStr string] rangeOfString:@"同意"].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:redRangeTwo];
    
    [noteLabel setAttributedText:noteStr];
    [noteLabel sizeToFit];
    [self.view addSubview:noteLabel];
}
- (void)TextString
{//截取字符串
    NSString *string =@"whatiswhoknow";
    string =[string substringToIndex:7];//截取下标7之qian的字符串
    NSLog(@"截取的值：%@",string);
    string =[string substringFromIndex:2];//截取下标2之hou的字符串
    NSLog(@"截取的值：%@",string);
//匹配字符串
    NSString *stringTwo =@"sdfghjkladf";
    NSRange range =[stringTwo rangeOfString:@"f"];//匹配得到的下标
    NSLog(@"rang:%@",NSStringFromRange(range));
    stringTwo =[stringTwo substringWithRange:range];//截取范围类的字符串
    NSLog(@"ok:%@",stringTwo);
//    分隔字符串
    NSString *stringThree =@"zxcvbnmcfghjk";
    NSArray *array =[stringThree componentsSeparatedByString:@"m"];//从字符m中分隔2个元素的数组
    NSLog(@"array:%@",array);
//    字符串分割
    NSString *str1 =@"1=2=3=4";
    NSArray *Array =[str1 componentsSeparatedByString:@"="];
    NSLog(@"%@",Array);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"http://blog.csdn.net/cc1991_/article/details/76718806");
        XianChengVC *vc =[[XianChengVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *phone =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"http://www.jb51.net/article/105897.htm 第一次进比较慢");
        UIImagePickerController *pickerImage =[[UIImagePickerController alloc]init];
        pickerImage.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.allowsEditing =YES;
        pickerImage.delegate =self;
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:camera];
    [alert addAction:phone];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

    // Do any additional setup after loading the view, typically from a nib.



@end
