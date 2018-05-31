//
//  City.h
//  PCDPlist
//
//  Created by Leon on 15/11/16.
//  Copyright © 2015年 上海指旺信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSMutableArray *districtArray;


@end
