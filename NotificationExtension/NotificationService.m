//
//  NotificationService.m
//  NotificationExtension
//
//  Created by anne on 17/2/10.
//  Copyright © 2017年 厉害了我的哥. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService
//收到一个远程推送的时候就会调用这个方法，你有30秒的时间来修改接收到的推送的内容<你可以去修改通知的内容，你也可以去下载推送的附件>，如果超过30秒了，你没有做任何的处理，系统就会自动的调用override func serviceExtensionTimeWillExpire(),如果你还不做出相应的操作，那么将显示最开始的通知的内容。
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire { //超过30s调用
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent); //
}

@end
