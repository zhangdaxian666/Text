//
//  XianChengVC.m
//  Aproject
// http://www.jb51.net/article/81616.htm
//  Created by slcf888 on 2017/11/21.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "XianChengVC.h"
#import "TaskNsobject.h"
@interface XianChengVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *apps;// 所有数据
@property (nonatomic, strong)NSMutableDictionary *imgCahe;// 内存缓存图片
@property (nonatomic,strong)NSMutableDictionary *operations;
@property (nonatomic,strong) NSOperationQueue *queue;
@end

@implementation XianChengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88)];
    tableview.delegate =self;
    tableview.dataSource =self;
    [self.view addSubview:tableview];
    // Do any additional setup after loading the view.
}
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        //最大并发数
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}
- (NSArray *)apps {
    if (!_apps) {
        //从plist文件中读取数据
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        NSMutableArray *appArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            [appArray addObject:[TaskNsobject appWithDict:dict]];
        }
        _apps = appArray;
    }
    return _apps;
}
- (NSMutableDictionary *)imgCahe
{
    if (!_imgCahe) {
        _imgCahe =[NSMutableDictionary dictionary];
    }
    return _imgCahe;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
//判断cell。 或者定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //fengge
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //右边尖头
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    TaskNsobject *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    //先从内存中取出图片
    UIImage *image = self.imgCahe[app.icon];
    if (image) {
        cell.imageView.image = image;
    }else {
        //内存中没有图片
        //将图片文件数据写入到沙盒中
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        //获得文件名
        NSString *filename = [app.icon lastPathComponent];
        //计算出文件的全路径
        NSString *file = [cachesPath stringByAppendingPathComponent:filename];
        //加载沙盒的文件数据
        NSData *data = [NSData dataWithContentsOfFile:file];
        //判断沙盒中是否有图片
        if (data) {
            //直接加载沙盒中图片
            UIImage *image = [UIImage imageWithData:data];
            cell.imageView.image = image;
            //存到字典(内存)中
            self.imgCahe[app.icon] = image;
        }else {
            //下载图片
            //占位图片
            cell.imageView.image = [UIImage imageNamed:@"place.jpg"];
            //先判断是否有下载任务
            //加载失败后可以重复下载
            NSOperation *operation = self.operations[app.icon];
            if (operation == nil) {
                //这张图片没有下载任务
                operation = [NSBlockOperation blockOperationWithBlock:^{
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
                    //数据加载失败
                    if(data == nil) {
                        //移除操作
                        [self.operations removeObjectForKey:app.icon];
                        return ;
                    }
                    UIImage *image = [UIImage imageWithData:data];
                    //存到内存中
                    self.imgCahe[app.icon] = image;
                    //回到主线程显示图片
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        //会出现重复占位的问题
                        //cell.imageView.image = image;
                        //只需找到图片所在的行即可
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    //将图片数据写入到沙盒中
                    [data writeToFile:file atomically:YES];
                    //移除操作
                    [self.operations removeObjectForKey:app.icon];
                }];
                //添加到下载队列
                [self.queue addOperation:operation];
                //添加到字典
                self.operations[app.icon] = operation;
            }
        }
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*https://www.cnblogs.com/cxbblog/p/3809238.html
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
