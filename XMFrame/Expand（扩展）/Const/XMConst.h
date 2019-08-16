//
//  XMConst.h
//  XMFrame
//
//  Created by Mifit on 2019/1/28.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 *  const共享一块空间，依据const位置设定不可修改部分。
 */

NS_ASSUME_NONNULL_BEGIN

/*
 *  常用数值
 *  C类型有效：const放*后面，内容不可修改；const放*前面，指向不可修改。
 */
// UI info
extern CGFloat const StatusHeight;          // 状态栏高度，20.0f
extern CGFloat const NavigationHeight;      // 导航栏高度，44.0f
extern CGFloat const TabbarHeight;          // tabbar 高度，50.0f
extern CGFloat const AlignWidth;            // 左右间距，15.0f
extern CGFloat const FringeSafeTop;         // 有刘海的安全top，24.0f
extern CGFloat const FringeSafeBottom;      // 有刘海的安全bottom，34.0f
// info length
extern NSInteger const PhoneLength;         // 电话号码长度
extern NSInteger const PasswordMinLength;   // 最短密码长度
extern NSInteger const PasswordMaxLength;   // 最长密码长度
extern NSInteger const IDCarLength;         // 身份证号码长度
extern NSInteger const CommentsMaxLength;   // 评论内容长度
// font size
extern NSInteger const ImportantSize32;     // 用于重要文字信息及标题，按钮文字
extern NSInteger const ImportantSize30;     // 用于导航栏文字，突出价格文字，小按钮文字，内页标题，普通级标题文字，列表页
extern NSInteger const ImportantSize28;     // 突出价格文字，小按钮文字
extern NSInteger const NormalSize26;        // 用于导航栏右侧说明文字，分导航弹窗文字
extern NSInteger const NormalSize24;        // 用于价格文字，辅助性次要文字，导航栏文字
extern NSInteger const WeakSize22;          // 用于商品页价格文字，辅助性次要文字
extern NSInteger const WeakSize20;          // 用于导航栏文字，提示性文字或较弱文字


/*
 *  颜色规范
 */
// 重要颜色
extern  NSString *const ImportantRedColor;     // 主色调，重要性文字，按钮和icon
extern  NSString *const ImportantBlueColor;    // 用于强调性的悬浮，弹框文字，按钮
extern  NSString *const ImportantBlackColor;   // 用于重要文字信息，内页标题 重要icon
// 一般颜色
extern  NSString *const NormalTextColor;       // 用于普通文字，段落，次要按钮
extern  NSString *const NormalAssistColor;     // 用于辅助性，次要文字
extern  NSString *const NormalDisableColor;    // 用于不可点击颜色 已失效颜色 输入框提示性文字颜色,个别按钮线框,icon
extern  NSString *const NormalOrangeColor;     // 用于分割模块底色
// 弱颜色
extern  NSString *const WeakAssistColor;       // 用于个别辅助性颜色
extern  NSString *const WeakLineColor;         // 用于内容区分割线颜色
extern  NSString *const WeakBackgroundColor;   // 用于分割模块底色



/*
 *  时间格式
 */
extern NSString *const kDateYearFormat;     // 月日
extern NSString *const kDateTimeFormat;     // 年月日时分秒
extern NSString *const kDateNormalFormat;   // 星期、年月日、时分秒、时区



/*
 *  通知key
 */
extern NSString *const kLoginStatusChangedNotification;     // 登录状态改变通知
extern NSString *const kIMLoginStatusChangedNotification;   // IM登录状态改变通知


/*
 *  Other key
 */
extern NSString *const kAppNotFirstLaunch;      // 非第一次启动
extern const NSString *const kUserAccessToken;  // accessToken

NS_ASSUME_NONNULL_END
