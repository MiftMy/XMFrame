//
//  XMConst.m
//  XMFrame
//
//  Created by Mifit on 2019/1/28.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "XMConst.h"

CGFloat const StatusHeight = 20.0f;
CGFloat const NavigationHeight = 44.0f;
CGFloat const TabbarHeight = 49.0f;
CGFloat const AlignWidth = 15.0f;
CGFloat const FringeSafeTop = 24.0f;
CGFloat const FringeSafeBottom = 34.0f;

NSInteger const PhoneLength = 11;
NSInteger const PasswordMinLength = 20;
NSInteger const PasswordMaxLength = 20;
NSInteger const IDCarLength = 18;
NSInteger const CommentsMaxLength = 500;

NSInteger const ImportantSize32 = 32;
NSInteger const ImportantSize30 = 30;
NSInteger const ImportantSize28 = 28;
NSInteger const NormalSize26 = 26;
NSInteger const NormalSize24 = 24;
NSInteger const WeakSize22 = 22;
NSInteger const WeakSize20 = 20;



const NSString *const ImportantRedColor = @"#e4393c";
const NSString *const ImportantBlueColor = @"#3993fc";
const NSString *const ImportantBlackColor = @"#33333";

const NSString *const NormalTextColor = @"#66666";
const NSString *const NormalAssistColor = @"#999999";
const NSString *const NormalDisableColor = @"#cccccc";
const NSString *const NormalOrangeColor = @"#f39500";

const NSString *const WeakAssistColor = @"#dddddd";
const NSString *const WeakLineColor = @"#eeeeee";
const NSString *const WeakBackgroundColor = @"#f5f5f5";




const NSString *const kDateYearFormat = @"yyyy-MM-dd";
const NSString *const kDateTimeFormat = @"yyyy-MM-dd HH:mm:ss";
const NSString *const kDateNormalFormat = @"EEE dd-MMM-yyyy HH:mm:ss Z";




const NSString *const kLoginStatusChangedNotification = @"kLoginStatusChangedNotification";
const NSString *const kIMLoginStatusChangedNotification = @"kIMLoginStatusChangedNotification";



const NSString *const kAppNotFirstLaunch = @"kAppNotFirstLaunch";
const NSString *const kUserAccessToken = @"kUserAccessToken";

/*
 纪元的显示：
 G：显示AD，也就是公元
 年的显示：
 yy：年的后面2位数字
 yyyy：显示完整的年
 月的显示：
 M：显示成1~12，1位数或2位数
 MM：显示成01~12，不足2位数会补0
 MMM：英文月份的缩写，例如：Jan
 MMMM：英文月份完整显示，例如：January
 
 日的显示：
 d：显示成1~31，1位数或2位数
 dd：显示成01~31，不足2位数会补0
 星期的显示：
 EEE：星期的英文缩写，如Sun
 EEEE：星期的英文完整显示，如，Sunday
 
 上/下午的显示：
 aa：显示AM或PM
 
 小時的显示：
 H：显示成0~23，1位数或2位数(24小时制
 HH：显示成00~23，不足2位数会补0(24小时制)
 K：显示成0~12，1位数或2位数(12小時制)
 KK：显示成0~12，不足2位数会补0(12小时制)
 
 分的显示：
 m：显示0~59，1位数或2位数
 mm：显示00~59，不足2位数会补0
 
 秒的显示：
 s：显示0~59，1位数或2位数
 ss：显示00~59，不足2位数会补0
 S： 毫秒的显示
 
 时区的显示：
 z / zz /zzz ：PDT
 zzzz：Pacific Daylight Time
 Z / ZZ / ZZZ ：-0800
 ZZZZ：GMT -08:00
 v：PT
 vvvv：Pacific Time
 */
