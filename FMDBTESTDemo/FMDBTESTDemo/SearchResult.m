//
//  SearchResult.m
//  NBSearchView
//
//  Created by Alesary on 15/11/17.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "SearchResult.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "AddressSearchModel.h"

@implementation SearchResult
/**
 *  获取搜索的结果集
 *
 *  @param text 搜索内容
 *
 *  @return 返回结果集
 */
+ (NSMutableArray*)getSearchResultBySearchText:(NSString*)searchText dataArray:(NSMutableArray*)dataArray
{
    NSMutableArray *searchResults = [NSMutableArray array];
    if (searchText.length>0&&![ChineseInclude isIncludeChineseInString:searchText]) {
        for (int i=0; i<dataArray.count; i++) {
            
            AddressSearchModel *model = dataArray[i];
            if ([ChineseInclude isIncludeChineseInString:model.addressStr]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:dataArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:dataArray[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
            }
            else {
                NSRange titleResult=[model.addressStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:model.addressStr];
                }
            }
        }
    } else if (searchText.length>0&&[ChineseInclude isIncludeChineseInString:searchText]) {
        for (AddressSearchModel *tempStr in dataArray) {
            NSRange titleResult=[tempStr.addressStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [searchResults addObject:tempStr];
            }
        }
    }
    return searchResults;
}

@end
