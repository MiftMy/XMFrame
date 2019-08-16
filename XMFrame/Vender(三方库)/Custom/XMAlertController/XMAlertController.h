//
//  XMAlertController.h
//  XMFrame
//
//  Created by Mifit on 2019/6/12.
//  Copyright © 2019 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


///  同UIAlertController UIAlertControllerStyleActionSheet，可添加图片
@interface XMAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title image:(UIImage *)image style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nullable, nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) UIAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end

@interface XMAlertController : UIViewController
@property (nonatomic, assign) NSInteger maxActionCount; // default: 8
@property (nullable, nonatomic, copy) NSString *alertTitle;
@property (nullable, nonatomic, copy) NSString *message;
//@property (nonatomic, readonly) UIAlertControllerStyle preferredStyle;
@property (nonatomic, readonly) NSArray<XMAlertAction *> *actions;

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
//+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)addAction:(XMAlertAction *)action;
@end

NS_ASSUME_NONNULL_END
