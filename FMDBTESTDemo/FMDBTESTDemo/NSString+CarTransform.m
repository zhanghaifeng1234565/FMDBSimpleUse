//
//  NSString+CarTransform.m
//  FMDBTESTDemo
//
//  Created by iOS on 2017/10/26.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "NSString+CarTransform.h"

@implementation NSString (CarTransform)

+ (NSString *)transformPinYin:(NSString *)carString {
    
    // 转换成可变字符串
    NSMutableString *strM = [NSMutableString stringWithString:carString];
    CFStringTransform((CFMutableStringRef)strM, NULL, kCFStringTransformMandarinLatin, NO);
    // 在转换成为不带声调的拼音
    CFStringTransform((CFMutableStringRef)strM, NULL, kCFStringTransformStripDiacritics, NO);
    NSArray *pinYinArr = [strM componentsSeparatedByString:@" "];
    NSMutableString *allStr = [NSMutableString new];
    
    // 拼音搜索
    int count=0;
    for (int i=0; i<pinYinArr.count; i++) {
        for (int i=0; i<pinYinArr.count; i++) {
            if (i==count) {
                [allStr appendString:@"#"]; // 区分是第几个字母
            }
            [allStr appendFormat:@"%@",pinYinArr[i]];
        }
        [allStr appendString:@","];
        count++;
    }
    
    // 首字母搜索
    NSMutableString *initStr = [NSMutableString new];
    for (NSString *s in pinYinArr) {
        if (s.length > 0) {
            [initStr appendString:[s substringToIndex:1]];
        }
    }
    
    [allStr appendFormat:@"#%@", initStr];
    [allStr appendFormat:@"#%@", carString];
    
    return allStr;
}

@end
