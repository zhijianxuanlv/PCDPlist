//
//  ViewController.m
//  PCDPlist
//
//  Created by Leon on 15/11/16.
//  Copyright © 2015年 上海指旺信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "Province.h"
#import "City.h"
#import "District.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *proPath = [[NSBundle mainBundle] pathForResource:@"zw_sys_province" ofType:@"json"];
    NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"zw_sys_city" ofType:@"json"];
    NSString *disPath = [[NSBundle mainBundle] pathForResource:@"zw_sys_district" ofType:@"json"];
    
    NSData *proData = [NSData dataWithContentsOfFile:proPath options:NSDataReadingMappedIfSafe error:nil];
    NSData *cityData = [NSData dataWithContentsOfFile:cityPath options:NSDataReadingMappedIfSafe error:nil];
    NSData *disData = [NSData dataWithContentsOfFile:disPath options:NSDataReadingMappedIfSafe error:nil];
    
    NSMutableDictionary *proDic = [NSJSONSerialization JSONObjectWithData:proData options:NSJSONReadingMutableContainers error:nil];
    NSMutableDictionary *cityDic = [NSJSONSerialization JSONObjectWithData:cityData options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableDictionary *disDic = [NSJSONSerialization JSONObjectWithData:disData options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *proArrays = [NSMutableArray array];
    NSMutableArray *cityArrays = [NSMutableArray array];
  
    
    NSArray *proArray = proDic[@"RECORDS"];
    NSArray *cityArray = cityDic[@"RECORDS"];
    NSArray *dicArray = disDic[@"RECORDS"];
    
    for (NSDictionary *dic in proArray) {

        
        NSDictionary *pro = @{
                              @"id" : dic[@"id"],
                              @"name" : dic[@"province_name"],
                              @"citys" :[NSMutableArray array]
                              };
        
        [proArrays addObject:pro];
    }
    
    for (NSDictionary *dic in cityArray) {
//        City *city = [City new];
//        city.cityId = dic[@"CITYID"];
//        city.cityName = dic[@"CITYNAME"];
//        city.districtArray = [NSMutableArray array];
        NSDictionary *city = @{
                              @"id" : dic[@"id"],
                              @"name" : dic[@"city_name"],
                              @"districts":[NSMutableArray array]
                              };
        
        
        [cityArrays addObject:city];
        
        for (NSDictionary *pro in proArrays) {
            if ([dic[@"province_id"] isEqualToString:pro[@"provinceId"]]) {
                [pro[@"citys"] addObject:city];
                break;
            }
        }
    }
    
    for (NSDictionary *dic in dicArray) {
//        District *dis  = [District new];
//        dis.districtId = dic[@"DISTRICTID"];
//        dis.districtName = dic[@"DISTRICTNAME"];
        NSDictionary *dis = @{
                               @"id" : dic[@"id"],
                               @"name" : dic[@"district_name"]
                               };
        
        
        for (NSDictionary *city in cityArrays) {
            if ([dic[@"city_id"] integerValue]== [city[@"cityId"] integerValue]) {
                [city[@"districts"] addObject:dis];
                break;
            }
        }
    }
    
    NSLog(@"TARGET ===> %@ ", proArrays);
    BOOL flag = [proArrays writeToFile:@"/Users/luocheng/Desktop/2.plist" atomically:YES];
    
    if(flag) {
        NSLog(@"ok");
    } else {
        NSLog(@"bad");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
