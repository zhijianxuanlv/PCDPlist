//
//  Province.h
//  PCDPlist
//
//  Created by Leon on 15/11/16.
//  Copyright © 2015年 上海指旺信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSMutableArray *cityArray;

@end
