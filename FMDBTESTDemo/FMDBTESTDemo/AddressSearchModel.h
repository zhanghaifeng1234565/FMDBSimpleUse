//
//  AddressSearchModel.h
//  FMDBTESTDemo
//
//  Created by iOS on 2017/10/26.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressSearchModel : NSObject

/**
 地址
 */
@property (nonatomic, copy) NSString *addressStr;

/**
 初始化模型

 @param dictionary 数据模型
 @return 数据模型
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
/**
 无条件查询数据

 @return 数据数组
 */
+ (NSMutableArray *)find;//查询所有的数据（无条件查询）

/**
 插入数据,注意CameraModel是你的文件的名,例如我新建的类就是CameraModel.h和CameraModel.m

 @param addressSearchModel 文件名
 @return 是否成功
 */
+ (BOOL)insertModel:(AddressSearchModel *)addressSearchModel;

/**
 删除数据，根据条件condition删除

 @param condition 删除条件
 @return 是否删除成功
 */
+ (BOOL)deleteModelWithCondition:(NSString *)condition;

/**
 模糊搜索

 @param key 关键字
 @return 数据数组
 */
+ (NSMutableArray *)select:(NSString *)key;

@end
