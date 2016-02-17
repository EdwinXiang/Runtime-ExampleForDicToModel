//
//  main.m
//  使用runtime实现字典转模型
//
//  Created by Edwin on 16/2/17.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "PersonModel.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
        for (int i = 0; i < 10; i++) {
            NSString *key = [NSString stringWithFormat:@"key%d",i];
            NSString *value = [NSString stringWithFormat:@"value%d",i];
            [data setObject:value forKey:key];
        }
        
        NSLog(@"data ==%@",data);
        //使用runtime对模型赋值
        PersonModel *model = [PersonModel newsWithDict:data];
        
        NSLog(@"key1 = %@",model.key1);
       
    }
    return 0;
}


