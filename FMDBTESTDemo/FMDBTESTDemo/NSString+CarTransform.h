//
//  NSString+CarTransform.h
//  FMDBTESTDemo
//
//  Created by iOS on 2017/10/26.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CarTransform)

/**
 获取汉字转换成拼音字符串

 @param carString 要转换的拼音
 @return 转换后的汉字
 */
+ (NSString *)transformPinYin:(NSString *)carString;

@end
