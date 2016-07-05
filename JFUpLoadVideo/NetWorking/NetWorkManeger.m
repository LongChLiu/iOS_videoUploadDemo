//
//  NetWorkManeger.m
//  36.UIGiftSay
//
//  Created by laouhn on 15/9/23.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "NetWorkManeger.h"
#import "AFHTTPSessionManager.h"

@interface NetWorkManeger  () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;

@property (nonatomic, strong) NSMutableData *data; // 用于存储data数据

@end

@implementation NetWorkManeger


//+ (void)postDataWithURL:(NSString *)urlStr parameter:(id)para successBlock:(successBlock)success fialBlock:(fialBlock)fial {
//    NetWorkManeger *net = [NetWorkManeger new];
//    // POST请求
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    // 设置请求类型
//    request.HTTPMethod = @"POST";
//    
//    // 设置请求体
//    request.HTTPBody = [para dataUsingEncoding:NSUTF8StringEncoding];;
//    // 设置连接代理
//    net.connection = [NSURLConnection connectionWithRequest:request delegate:net];
//    
//    net.success = success;
//    net.fial = fial;
//}
//
//
//// 服务器接收响应
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    self.data = [NSMutableData data];
//}
//
//
//
//// 收到数据
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [self.data appendData:data];
//}
//
//
//// 结束加载
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    // 解析数据
//    id obj = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
//    
//    // Block 回调数据
//    self.success(self, obj);
//    
//    
//    
//    // 先判断delegate是否存在, 然后判断delegate 是否响应方法
//    if (self.deletate && [self.deletate respondsToSelector:@selector(getDataSuccess:object:)]) {
//        [self.deletate getDataSuccess:self object:obj];
//    }
//}
//
//// 请求失败
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    
//    // Blcok 回到错误信息
//    self.fial(self, error);
//    
//    // 先判断delegate是否存在, 然后判断delegate 是否响应方法
//    if (self.deletate && [self.deletate respondsToSelector:@selector(getDataFail:error:)]) {
//        [self.deletate getDataFail:self error:error];
//    }
//}



+ (void)postDataWithURL:(NSString *)urlStr parameter:(id)para successBlock:(successBlock)success fialBlock:(fialBlock)fial {
    
    NetWorkManeger *net = [NetWorkManeger new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:urlStr parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        success (net, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        fial (net, error);
    }];
}






- (void)getDataWithURL:(NSString *)urlStr success:(successBlock)success fialBlock:(fialBlock)fial {
    // GET 请求
    // 创建URL 对象
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建求情 NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 链接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
        // 如果data存在, 解析, 成功回调
       id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        success(self, obj);
            
        } else {
             // 反之, 失败回调;
            fial(self, nil);
        }

       
        
    }];
    
    
}


@end
