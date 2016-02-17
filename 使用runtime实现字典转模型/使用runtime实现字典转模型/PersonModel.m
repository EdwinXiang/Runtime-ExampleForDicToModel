//
//  PersonModel.m
//  使用runtime实现字典转模型
//
//  Created by Edwin on 16/2/17.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "PersonModel.h"
#import <objc/runtime.h>
@implementation PersonModel
const char *propertiesKey = "propertiesKey";
+(NSArray *)allPropertyNames{
    //判断是否存在关联对象  如果存在直接返回
    NSArray *plist = objc_getAssociatedObject(self, propertiesKey);
    if (plist != nil) {
        return plist;
    }
    //存储所有属性的名称
    NSMutableArray *allNames = [NSMutableArray array];
    //1获取类的属性
    //参数是 类 和属性的计数指针  返回值是所有属性的数组
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = propertys[i];
        const char *propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    //释放
    free(propertys);
    NSLog(@"allname ===%@",allNames);
    
    //5 设置关联对象
    //参数1>关联的对象
    //参数2>关联对象的key
    //参数3>属性数值
    //属性的持有方式 retain copy assign
    objc_setAssociatedObject(self, propertiesKey, allNames, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return allNames.copy;
}

+ (instancetype)newsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    //    [obj setValuesForKeysWithDictionary:dict];
    NSArray *properties = [self allPropertyNames];
    
    // 遍历属性数组
    for (NSString *key in properties) {
        // 判断字典中是否包含这个key
        if (dict[key] != nil) {
            // 使用 KVC 设置数值
            [obj setValue:dict[key] forKeyPath:key];
        }
    }
    
    return obj;
}
@end
