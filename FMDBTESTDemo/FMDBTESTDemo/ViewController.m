//
//  ViewController.m
//  FMDBTESTDemo
//
//  Created by iOS on 2017/10/26.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "ViewController.h"
#import "AddressSearchModel.h"
#import "SearchResult.h"

@interface ViewController ()<UITextViewDelegate,UIAlertViewDelegate>

@end

@implementation ViewController {
    UITableView *_dataTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showTextView.layer.masksToBounds=YES;
    self.showTextView.layer.cornerRadius=2.0f;
    self.showTextView.layer.borderWidth=0.5f;
    self.showTextView.layer.borderColor=[UIColor blueColor].CGColor;
    self.showTextView.delegate=self;
    
}

#pragma mark -- 插入
- (IBAction)chaRuBtnClick:(UIButton *)sender {
    
    if (self.showTextView.text.length > 0) {
        
        NSArray *data=[AddressSearchModel find];
        for(int i=0;i<data.count;i++){
            AddressSearchModel *model=data[i];//数组的每个元素都是一个model
            NSString *addStr=model.addressStr;//可以读取数据的uid的值
            if ([addStr isEqualToString:self.showTextView.text]) {
                UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"改地址已存在，不需要添加！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alt show];
                return;
            }
            
        }
        AddressSearchModel *model=[AddressSearchModel new];
        model.addressStr=[NSString stringWithFormat:@"%@",self.showTextView.text];
        [AddressSearchModel insertModel:model];
        
    } else {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"输入搜索内容" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
        [alt show];
    }
    
}
#pragma mark -- 删除
- (IBAction)shanChuBtnClick:(UIButton *)sender {
    
    //删除
    NSString *uid=self.showTextView.text;
    [AddressSearchModel deleteModelWithCondition:uid];
    
}
#pragma mark -- 查询
- (IBAction)chaXunBtnClick:(UIButton *)sender {
    
    
    //查询
    NSMutableArray *addressArr = [[NSMutableArray alloc] init];
    NSMutableArray *data=[AddressSearchModel find];//data就是数据库里面所有数据的数组
    NSMutableArray *resultData = [[NSMutableArray alloc] init];
    resultData = [SearchResult getSearchResultBySearchText:self.showTextView.text dataArray:data];
    for(int i=0;i<resultData.count;i++){
        AddressSearchModel *model=resultData[i];//数组的每个元素都是一个model
        NSString *addStr=model.addressStr;//可以读取数据的uid的值
        [addressArr addObject:addStr];
        NSLog(@"%@", addStr);
    }
    self.showLabel.text = @"";
    for (int i = 0; i<addressArr.count; i++) {
        self.showLabel.text =  [self.showLabel.text stringByAppendingString:addressArr[i]];
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text length]>0) {
        //查询
        NSMutableArray *addressArr = [[NSMutableArray alloc] init];
        NSMutableArray *data=[AddressSearchModel select:textView.text];//data就是数据库里面所有数据的数组
        NSMutableArray *resultData = [[NSMutableArray alloc] init];
        
        resultData  = [SearchResult getSearchResultBySearchText:self.showTextView.text dataArray:data];
//        for(int i=0;i<resultData.count;i++){
//            AddressSearchModel *model=resultData[i];//数组的每个元素都是一个model
////            NSString *addStr=model;//可以读取数据的uid的值
//            [addressArr addObject:model];
////            NSLog(@"%@", addStr);
//        }
        
        self.showLabel.text = @"";
//        for (int i = 0; i<resultData.count; i++) {
//            AddressSearchModel *model=resultData[i];
//            self.showLabel.text =  [self.showLabel.text stringByAppendingString:model.addressStr];
//        }
        self.showLabel.text = [NSString stringWithFormat:@"%@",resultData[0]];
//        NSLog(@"%@",resultData);
    } else {
        self.showLabel.text = @"";
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.showTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
