//
//  PushViewController.m
//  Aproject
//
//  Created by slcf888 on 2017/11/20.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "PushViewController.h"
#import "CustCollectionViewlayout.h"
#import "CustomCollectionViewCell.h"
#import "ViewController.h"
#import "PhotoViewController.h"

#import "XianChengVC.h"
#import "MoreViewController.h"
#define TopHeight 88
@interface PushViewController ()<CustCollectionViewlayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *imageArray;
    UICollectionView *customcollectionView;
}
@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"江湖";
    imageArray =@[[UIImage imageNamed:@"Unknown-0"],[UIImage imageNamed:@"Unknown-1"],[UIImage imageNamed:@"Unknown-2"],[UIImage imageNamed:@"Unknown-3"],[UIImage imageNamed:@"Unknown-4"],[UIImage imageNamed:@"Unknown-5"],[UIImage imageNamed:@"Unknown-6"],[UIImage imageNamed:@"Unknown-7"],[UIImage imageNamed:@"Unknown-8"],[UIImage imageNamed:@"Unknown-9"],[UIImage imageNamed:@"Unknown-10"],[UIImage imageNamed:@"Unknown-11"]];
    CustCollectionViewlayout *layout =[[CustCollectionViewlayout alloc]init];
    layout.delegate =self;
//    customcollectionView =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    customcollectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, TopHeight, self.view.frame.size.width, self.view.frame.size.height-TopHeight) collectionViewLayout:layout];
    customcollectionView.backgroundColor =[UIColor whiteColor];
    customcollectionView.delegate =self;
    customcollectionView.dataSource =self;
    [customcollectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"nil"];
    [self.view addSubview:customcollectionView];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"nil" forIndexPath:indexPath];
    cell.imageview.image =imageArray[indexPath.item];
    cell.imageview.frame =cell.bounds;
    return cell;
}
-(CGSize)itemSizeForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    UIImage *image = imageArray[indexPath.item];
    CGFloat width = self.view.frame.size.width;
    return CGSizeMake((width-10*2-10)/2,image.size.height/image.size.width*(width-10*2-10)/2 );
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            ViewController *vc =[[ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];}
            break;
        case 1:{
            PhotoViewController *vc =[[PhotoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];}
            break;
        case 2:{
            XianChengVC *vc =[[XianChengVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];        }
            break;
        case 3:{
            MoreViewController *vc =[[MoreViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        default:
            break;
    }
//    NSLog(@"xxxxx%@xxxxxx",imageArray[indexPath.item]);
//    NSLog(@"xxxx%ldxxxxx",indexPath.row);
//    ViewController *vc =[[ViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
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
