//
//  ViewController.m
//  NSCoreData
//
//  Created by lst on 16/7/18.
//  Copyright © 2016年 lst. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Clothes.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
//声明一个属性APPDelegate 独享属性  来调用类中属性被管理对象上下文
@property (nonatomic, strong) AppDelegate *myAppDelegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化数组
    self.dataSource = [NSMutableArray array];
    self.myAppDelegate = [UIApplication sharedApplication].delegate;
    
    
    /**
     *  在 view 加载过程中进行 coreData 的查询
     *
     */
    //创建 NSFetcheRequst
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Clothes"];
    
    //设置查询对象排序
    //1.1创建排序描述对象
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"price" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    //执行查询请求
    //创建一个错误
    NSError *error = nil;
    
    
    NSArray *reslut = [self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error];
    //给数据源添加数据
    [self.dataSource addObjectsFromArray:reslut];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  插入数据
 *
 *  @param sender +barButtonItem
 */
- (IBAction)addModle:(id)sender {
    
    //点击方法中完成插入数据
    //创建模型对象
    /**
     entityDescription 实体描述对象
     */
    //创建实体描述
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Clothes" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    
    Clothes *clothes = [[Clothes alloc]initWithEntity:description insertIntoManagedObjectContext:
                        self.myAppDelegate.managedObjectContext];
    
    clothes.name = @"Puma";
    
    int price = arc4random() % 1000 + 1;
    
    clothes.price = [NSNumber numberWithInt:price];
    
    clothes.type = @"A100";
    
    //插入数据源数组
    [self.dataSource addObject:clothes];
    //插入 UI
    /**
     *  插入 UI 方法
     *
     *  @param NSIndexSet @[NSIndexPath indexPathForRow:self.dataSource.count - 1 insection:0]
     *
     *  @return <#return value description#>
     */
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft ];
    //对数据管理器的更改 做持久化存储
    [self.myAppDelegate saveContext];
    
    
}


#pragma mark  -UITableViewDelegate,UITableViewDataSource
/**
 *  返回分区间的行数
 *
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Clothes *clothes = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@__%@__%@",clothes.name,clothes.price,clothes.type];
    
    return cell;
}

/**
 *  想做清扫可以删除 cell
 */
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
/**
 *  可编辑类型
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //先取出模型
        Clothes *clothe = self.dataSource[indexPath.row];
        //删除数据源
        [self.dataSource removeObject:clothe];
        //删除数据管理器里的数据
        [self.myAppDelegate.managedObjectContext deleteObject:clothe];
        //保存
        [self.myAppDelegate saveContext];
        //删除单元格
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

/**
 *  点击 cell 实现内容修改
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //找到模型对象
    Clothes *cloth = self.dataSource[indexPath.row];
    
    cloth.name = @"NIKE";
    //更改数据源
    
    
    //刷新 UI
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //save
    [self.myAppDelegate saveContext];
}



@end
