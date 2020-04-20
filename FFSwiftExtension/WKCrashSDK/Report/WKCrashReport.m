//
//  WKCrashReport.m
//  OCHookWithLibffi
//
//  Created by wangkun on 2018/7/4.
//  Copyright © 2018年 wangkun. All rights reserved.
//

#import "WKCrashReport.h"
#import <UIKit/UIKit.h>
#import "WKHeader.h"
#import "DeviceUtil.h"
@interface WKCrashModel ()

@property (nonatomic, strong) NSString * deviceType;
@property (nonatomic, strong) NSString * systemVersion;

@end

@implementation WKCrashModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.systemVersion = [[UIDevice currentDevice] systemVersion]; //获取系统版本 例如：9.2
        self.deviceType = [[WKCrashModel util] hardwareString];
    }
    return self;
}

+ (DeviceUtil *)util
{
    static DeviceUtil * util = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [DeviceUtil new];
    });
    return util;
}

@end

static NSString * preStr = @"WK+++ML";

@interface WKCrashReport ()

@end

@implementation WKCrashReport

+ (instancetype)sharedReport
{
    static WKCrashReport * report = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        report = [WKCrashReport new];
    });
    return  report;
}


#pragma mark 存储相关
/*
 存储样式：  原因 和 stack 信息，还有就是对应的不同crash是不是存储的东西应该不一样
 @{@"ClassName":@[@"selName分割符count"]}
 */


+ (void)crashInfo:(WKCrashModel *)model type:(WKCrashType)type
{
    WKCrashReport * report = [self sharedReport];
    
    NSString * crashTypeKey = [self getPathKeyWithType:type];

#ifdef DEBUG
    NSLog(@"============================================");
    NSLog(@">>>>>>>>>>>> Crash <<<<<<<<<<<<<<");
    NSLog(@">>>>>>>>>>>> CrashType : %@ <<<<<<<<<<<<<<",crashTypeKey);
    NSLog(@">>>>>>>>>>>> CrashClass : %@ <<<<<<<<<<<<<<",model.clasName);
    NSLog(@">>>>>>>>>>>> CrashMsg : %@ <<<<<<<<<<<<<<",model.msg);
    NSLog(@">>>>>>>>>>>> CrashStackInfo ↓ <<<<<<<<<<<<<<");
    NSLog(@"%@",model.threadStack);
    NSLog(@"============================================");
#endif
    
    NSMutableDictionary * extraInfo = [NSMutableDictionary dictionary];
    [extraInfo setObject:model.systemVersion ?: @"" forKey:@"SystemVersion"];
    [extraInfo setObject:model.deviceType ?: @"" forKey:@"DeviceType"];
    
    //此处上报 我这边使用的是bugly上报
//    [Bugly reportExceptionWithCategory:3 name:crashTypeKey reason:model.msg callStack:model.threadStack extraInfo:extraInfo terminateApp:NO];

    
    if ([report.delegate respondsToSelector:@selector(handleCrashInfo:type:)]) {
        [report.delegate handleCrashInfo:model type:crashTypeKey];
    }
    //崩溃信息本地存储
    ///考虑 加入 ios版本号，设备型号，堆栈信息
    model.time = [NSDate date].timeIntervalSince1970;
    NSString * timeStr = [NSString stringWithFormat:@"%.0lf",model.time];
    
    NSDictionary * dict = [self getCrashReportWithType:type];
    if (dict)
    {
        NSMutableDictionary * newDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        BOOL isAdd = NO;
        for (NSString * key in [newDict allKeys]) {
            //类名存在的情况
            if ([key isEqualToString:model.clasName]) {
                NSArray * infos = [newDict objectForKey:key];
                //如果取出来的数据不是arr，则直接删除掉，使用新的arr
                if (![infos isKindOfClass:[NSArray class]]) {
                    infos = [NSArray array];
                }
                NSMutableArray * newInfos = [NSMutableArray array];
                for (NSString * sel in infos) {//分割 +selname分割符count
                    NSArray * result = [sel componentsSeparatedByString:preStr];
                    //如果数量小于2 表明为脏数据 抛开
                    if (result.count >= 2) {
                        NSMutableString * newSelName = [NSMutableString string];
                        //已监听到过 调用此方法崩溃，则调用次数+1
                        if ([result.firstObject isEqualToString:model.msg]) {
                            //生成新的count数据
                            NSUInteger count = [[result objectAtIndex:1] integerValue] + 1;
                            NSString * countStr = [NSString stringWithFormat:@"%ld",count];
                            //利用新数组 组装数据
                            NSMutableArray * newResultArr = [NSMutableArray arrayWithArray:result];
                            newResultArr[1] = countStr;
                            if (newResultArr.count > 2) {
                                newResultArr[2] = timeStr;
                            }
                            else
                            {
                                [newResultArr addObject:timeStr];
                            }
                            
                            for (NSUInteger i = 0; i < newResultArr.count; i++) {
                                [newSelName appendString:newResultArr[i]];
                                if (i < newResultArr.count - 1) {
                                    [newSelName appendString:preStr];
                                }
                            }
                            isAdd = YES;
                        }
                        else //未监听到
                        {
                            [newSelName appendString:sel];
                        }
                        [newInfos addObject:newSelName];
                    }
                }
                //selname是首次 添加
                if (!isAdd) {
                    NSMutableString * addSelName = [NSMutableString string];
                    [addSelName appendString:model.msg];
                    [addSelName appendString:preStr];
                    [addSelName appendString:@"1"];
                    [addSelName appendString:preStr];
                    [addSelName appendString:timeStr];
                    isAdd = YES;
                    [newInfos addObject:addSelName];
                }
                [newDict setValue:newInfos forKey:key];
                break;
            }
        }
        //classname 是首次
        if (!isAdd) {
            NSString * str = [NSString stringWithFormat:@"%@%@1%@%@",model.msg,preStr,preStr,timeStr];
            
            [newDict setValue:@[str] forKey:model.clasName];
            isAdd = YES;
        }
        NSString * path = [self getCrashLogPathType:type];
        if (path) {
            __unused BOOL flag = [newDict writeToFile:path atomically:YES];
        }
    }
    
}

+ (NSString *)getPathKeyWithType:(WKCrashType)type
{
    NSString * key = nil;
    switch (type) {
        case WKCrashType_UnrecognizedSelector:
            key = @"UnrecognizedSelector";
            break;
        case WKCrashType_KVO:
            key = @"KVO";
            break;
        case WKCrashType_Container:
            key = @"Container";
            break;
        case WKCrashType_Timer:
            key = @"Timer";
            break;
        case WKCrashType_NotificationCenter:
            key = @"NotificationCenter";
            break;
        case WKCrashType_Null:
            key = @"Null";
            break;
        case WKCrashType_String:
            key = @"String";
            break;
        case WKCrashType_Zombie:
            key = @"Zombie";
            break;
    }
    return key;
}

+ (NSString *)getCrashLogPathType:(WKCrashType)type
{
    NSString * key = [self getPathKeyWithType:type];

    if (!key) {
        return nil;
    }
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath= paths.firstObject;
    NSString * lastPath = [NSString stringWithFormat:@"WK_%@.CrashLog",key];
    NSString *dicPath = [documentsPath stringByAppendingPathComponent:lastPath];
    return dicPath;
}

+ (NSDictionary *)getContentWithPaht:(NSString *)path
{
    NSDictionary * dict = [NSDictionary dictionary];
    if (!path) {
        return dict;
    }
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL bRet = [fileMgr fileExistsAtPath:path];
    if (bRet) {
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return dict;
}

+ (NSDictionary *)getCrashReportWithType:(WKCrashType)type
{
    NSString * path  = [self getCrashLogPathType:type];
    NSDictionary * dict = [self getContentWithPaht:path];
    return dict;
}

+ (NSArray *)getAllCrashReport
{
    NSMutableArray * arr = [NSMutableArray array];
    NSUInteger count = 8;
    for (NSUInteger i = 0; i < count; i ++) {
        NSDictionary * dict = [self getCrashReportWithType:i];
        [arr addObject:dict];
    }
    return arr.copy;
}

+ (NSArray *)decodeWithString:(NSString *)str
{
    return [str componentsSeparatedByString:preStr];
}

@end
