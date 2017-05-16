
//
//  ZKPushManager.m
//  few
//
//  Created by anne on 16/12/27.
//  Copyright © 2016年 厉害了我的哥. All rights reserved.
//

#import "ZKPushManager.h"
#import "AppDelegate.h"

@implementation ZKPushManager
+ (AppDelegate *)delegate {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate;
}

//可以添加一些通知，如进入后台等时候的特殊操作

+ (instancetype)shared {
    static ZKPushManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZKPushManager alloc] init];
    });
    
    return manager;
}

- (void)postProviderWithToken:(NSString *)token{
    //将推送token发送给服务器
    
}


#pragma mark -- 推送处理
// 处理推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"推送userInfo-----%@",userInfo);
    
    if (application.applicationState != UIApplicationStateActive) { //后台或退出
        [ZKPushManager clearSysBardage];
        
        
    }else{  //前台 不跳转，改变badge 发出声音  或弹窗
        
        
        
    }
}


- (void)handePresentViewController:(UIViewController *) pViewController{
    
    
}



#pragma mark  --- 推送信息存储 --rootVC
- (UIViewController *)rootViewController {
    UIViewController *viewController = [ZKPushManager delegate].window.rootViewController;
    return viewController;
}

- (NSString *)filePath{
    NSString * documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString * filePath = [documents stringByAppendingPathComponent:@"SystemMessages"];
    return filePath;
}

- (void)saveMessagesReset:(BOOL)reset{
    
    BOOL ret = [_systemMessages writeToFile:[self filePath]
                                 atomically:YES];
    if (!ret) {
        
    }
}


- (void)loadMessages{
    self.systemMessages = [NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
}


//清除系统推送角标
+(void)clearSysBardage{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
