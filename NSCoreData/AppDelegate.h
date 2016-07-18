//
//  AppDelegate.h
//  NSCoreData
//
//  Created by lst on 16/7/18.
//  Copyright © 2016年 lst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//被管理对象上下文(数据管理器) 相当于一个临时数据互
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//被管理对象模型(数据模型器) 
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久化存储助理(数据连接器)coreData 的核心
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//把临时数据库中进行的改变进行保存
- (void)saveContext;
//获取真实存储路径
- (NSURL *)applicationDocumentsDirectory;


@end

