//
//  Clothes+CoreDataProperties.h
//  NSCoreData
//
//  Created by lst on 16/7/18.
//  Copyright © 2016年 lst. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Clothes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Clothes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
