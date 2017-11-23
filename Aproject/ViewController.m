//
//  ViewController.m
//  Aproject
//  http://www.jb51.net/article/105897.htm//提示框
//  Created by slcf888 on 2017/11/20.
//  Copyright © 2017年 slcf888. All rights reserved.
//  http://blog.csdn.net/icandyss/article/details/50298877  label

#import "ViewController.h"
#import "VideoView.h"
#import "XianChengVC.h"
@interface ViewController ()<VideoViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) VideoView *videoView;
@property (nonatomic ,strong) NSMutableArray<NSLayoutConstraint *> *array;
@property (nonatomic ,strong) UISlider *videoSlider;
@property (nonatomic ,strong) NSMutableArray<NSLayoutConstraint *> *sliderArray;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self initVideoView];
    UILabel *mylabel =[[UILabel alloc]initWithFrame:CGRectMake(40, 500, 200, 100)];
    [self.view addSubview:mylabel];
    NSString *text =@"标签文本10086";
    //设置标签文本
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    // 获取标红的位置和长度
   //  NSRange range = [result rangeOfString:keyword];
    //设置标签文本属性
    [attributeString setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(4, 3)];
    mylabel.attributedText = attributeString; //显示
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
        NSLog(@"http://www.jb51.net/article/105897.htm");
        
    }];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:camera];
    [alert addAction:phone];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)initVideoView {
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"some" ofType:@"mp4"];//这个时播放本地的，播放本地的时候还需要改VideoView.m中的代码
    NSString *path = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    _videoView = [[VideoView alloc] initWithUrl:path delegate:self];
    _videoView.someDelegate = self;
    [_videoView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_videoView];
    [self initVideoSlider];
    
    if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        [self installLandspace];
    } else {
        [self installVertical];
    }
}
- (void)installVertical {
    if (_array != nil) {
        [self.view removeConstraints:_array];
        [_array removeAllObjects];
        [self.view removeConstraints:_sliderArray];
        [_sliderArray removeAllObjects];
    } else {
        _array = [NSMutableArray array];
        _sliderArray = [NSMutableArray array];
    }
    id topGuide = self.topLayoutGuide;
    NSDictionary *dic = @{@"top":@100,@"height":@180,@"edge":@20,@"space":@80};
    [_array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_videoView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_videoView)]];
    [_array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(edge)-[_videoSlider]-(edge)-|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(_videoSlider)]];
    [_array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topGuide]-(top)-[_videoView(==height)]-(space)-[_videoSlider]" options:0 metrics:dic views:NSDictionaryOfVariableBindings(_videoView,topGuide,_videoSlider)]];
    [self.view addConstraints:_array];
    
    
    
}
- (void)installLandspace {
    if (_array != nil) {
        
        [self.view removeConstraints:_array];
        [_array removeAllObjects];
        
        [self.view removeConstraints:_sliderArray];
        [_sliderArray removeAllObjects];
    } else {
        
        _array = [NSMutableArray array];
        _sliderArray = [NSMutableArray array];
    }
    
    id topGuide = self.topLayoutGuide;
    NSDictionary *dic = @{@"edge":@20,@"space":@30};
    
    [_array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_videoView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_videoView)]];
    [_array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topGuide][_videoView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_videoView,topGuide)]];
    [self.view addConstraints:_array];
    
    [_sliderArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(edge)-[_videoSlider]-(edge)-|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(_videoSlider)]];
    [_sliderArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_videoSlider]-(space)-|" options:0 metrics:dic views:NSDictionaryOfVariableBindings(_videoSlider)]];
    [self.view addConstraints:_sliderArray];
}
- (void)initVideoSlider {
    
    _videoSlider = [[UISlider alloc] init];
    [_videoSlider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_videoSlider setThumbImage:[UIImage imageNamed:@"sliderButton"] forState:UIControlStateNormal];
    [self.view addSubview:_videoSlider];
    
}
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        
        if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
            [self installLandspace];
        } else {
            [self installVertical];
        }
        [self.view setNeedsLayout];
    } completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -
- (void)flushCurrentTime:(NSString *)timeString sliderValue:(float)sliderValue {
    _videoSlider.value = sliderValue;
}
    // Do any additional setup after loading the view, typically from a nib.



@end
