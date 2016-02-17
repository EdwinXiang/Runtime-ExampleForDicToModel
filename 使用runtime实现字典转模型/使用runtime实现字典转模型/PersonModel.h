//
//  PersonModel.h
//  使用runtime实现字典转模型
//
//  Created by Edwin on 16/2/17.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property (nonatomic,copy) NSString *key0;
@property (nonatomic,copy) NSString *key1;
@property (nonatomic,copy) NSString *key2;
@property (nonatomic,copy) NSString *key3;

+(NSArray *)allPropertyNames;

+ (instancetype)newsWithDict:(NSDictionary *)dict;
@end
