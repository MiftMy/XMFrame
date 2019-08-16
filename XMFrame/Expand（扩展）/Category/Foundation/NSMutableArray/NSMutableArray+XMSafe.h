//
//  NSMutableArray+XMSafe.h
//  XMFrame
//
//  Created by Mifit on 2019/1/24.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 * 方法同下划线后的原类方法，提供安全操作
 */
@interface NSMutableArray (XMSafe)
// removeObject: nil 不崩溃
+ (void)loadSafe;

- (id)safe_objectAtIndex:(NSUInteger)index;

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)safe_removeObjectAtIndex:(NSUInteger)index;

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (instancetype)safe_initWithCapacity:(NSInteger)capacity;
@end

NS_ASSUME_NONNULL_END
