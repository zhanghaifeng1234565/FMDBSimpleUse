//
//  AddressSearchModel.m
//  FMDBTESTDemo
//
//  Created by iOS on 2017/10/26.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "AddressSearchModel.h"
#import <FMDB.h>
#import "NSString+CarTransform.h"

#define Cameras @"addressTableName"//表名为tableName

#define Col1 @"address"//表的第一个字段名


@implementation AddressSearchModel
- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+(NSMutableArray *)find{
    
    NSMutableArray *array = [NSMutableArray array];
    //使用fmdb创建数据库
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"address.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('address' TEXT)",Cameras];//如果表不存在，则创建表
    [db executeUpdate:sqlCreateTable];
    
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",Cameras];//SQL语句无条件查询
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            AddressSearchModel *m = [[AddressSearchModel alloc] init];
            m.addressStr = [rs stringForColumn:Col1];
            [array addObject:m];
        }
        [db close];
    }
    
    return array;
    
}

+(BOOL)insertModel:(AddressSearchModel *)m{
    BOOL flag = NO;
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"address.sqlite"];//cameras.sqlite是数据库名，dbpath是数据库完整的地址
    
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];//打开数据库
    NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('address' TEXT)",Cameras];//SQL语句创建表
    [db executeUpdate:sqlCreateTable];
    
//    NSString *address = [NSString transformPinYin:m.addressStr];
    if ([db open]) {
        NSString *insertSql1= [NSString stringWithFormat:
                               @"INSERT INTO '%@' ('%@') VALUES ('%@')",
                               Cameras,Col1, m.addressStr];//SQL语句插入
        flag = [db executeUpdate:insertSql1];
    }
    
    return flag;
    
}

+(BOOL)deleteModelWithCondition:(NSString *)condition
{
    BOOL flag = NO;
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"address.sqlite"];
    
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('address' TEXT)",Cameras];
    [db executeUpdate:sqlCreateTable];
    
    if ([db open]) {
        NSString *string1=[@"'" stringByAppendingString:condition];
        NSString *string2=[string1 stringByAppendingString:@"'"];
        NSString *insertSql1= [NSString stringWithFormat:
                               @"DELETE FROM %@ WHERE address = %@",Cameras,string2
                               ];
        flag = [db executeUpdate:insertSql1];
    }
    
    return flag;
}

+ (NSMutableArray *)select:(NSString *)key {
    
    NSString *selectSql;
    if (key.length!=0||key) {
        selectSql = [NSString stringWithFormat:@"select * from addressTableName where address like '%%%@%%'",key];
    } else {
        selectSql=[NSString stringWithFormat:@"select * form addressTableName"];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    //使用fmdb创建数据库
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"address.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    if ([db open]) {
        
        FMResultSet * rs = [db executeQuery:selectSql];
        while ([rs next]) {
            AddressSearchModel *m = [[AddressSearchModel alloc] init];
            m.addressStr = [rs stringForColumn:Col1];
            [array addObject:m];
        }
        [db close];
    }
    
    return array;
}

@end
