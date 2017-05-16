//
//  ZKPushManager.h
//  few
//
//  Created by anne on 16/12/27.
//  Copyright © 2016年 厉害了我的哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0)
#define IOS8_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 10.0)
#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)


@interface ZKPushManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *systemMessages;

+ (instancetype)shared;

- (void)postProviderWithToken:(NSString *)token;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;


- (void)loadMessages;
- (void)handePresentViewController:(UIViewController *) pViewController;

//清除系统推送角标
+(void)clearSysBardage;

@end
