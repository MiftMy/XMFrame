//
//  XMKeychain.h
//  XMFrame
//
//  Created by Mifit on 2019/2/21.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 三方库：SAMKeychain
@interface XMKeychain : NSObject

@end

NS_ASSUME_NONNULL_END

/*
 
 keychain不能添加相同的item
 操作方法：
 // 查询 OSStatus SecItemCopyMatching(CFDictionaryRefquery,CFTypeRef*result);
 // 添加 OSStatus SecItemAdd(CFDictionaryRefattributes,CFTypeRef*result);
 // 更新 OSStatus SecItemUpdate(CFDictionaryRefquery,CFDictionaryRefattributesToUpdate);
 // 删除 OSStatus SecItemDelete(CFDictionaryRefquery)
 
 
 传递参数（字典类型）：
 key ：
 kSecClass（条目类别）
 kSecAttrAccessible             （什么时候访问）
 kSecAttrProtocol               （协议）
 kSecAttrAuthenticationType     （item授权）
 kSecAttrKeyClass               （只读的）
 kSecAttrKeyType                （加密算法）
 kSecAttrPRF                    （伪随机方法）
 Search Constants               （查询条件）
 Return Type Key Constants      （返回值类型）      kSecReturnData
 Value Type Key Constants       （存入值的类型）    kSecValueData
 Other Constants
 
 
 其中
 kSecClass value(5 个):
 kSecClassGenericPassword(通用密码－－也是接下来使用的)、
 kSecClassInternetPassword(互联网密码)、
 kSecClassCertificate(证书)、
 kSecClassKey(密钥)、
 kSecClassIdentity(身份)
 
 
 主key推荐
 kSecClassGenericPassword kSecAttrService、kSecAttrAccount
 
 kSecClassInternetPassword
 kSecAttrAccount、kSecAttrSecurityDomain、kSecAttrServer、kSecAttrProtocol、kSecAttrAuthenticationType、kSecAttrPath
 
 kSecClassCertificate
 kSecClassCertificateType、kSecAttrIssuer、kSecAttrSerialNumber
 
 kSecClassKey
 kSecAttrApplicationLabel、kSecAttrApplicationTag、kSecAttrKeyType、kSecAttrKeySizeInBits、kSecAttrEffectiveKeySize
 
 kSecClassIdentity
 kSecClassKey、kSecClassCertificate
 
 
 
 kSecClassGenericPassword可选项：
 kSecAttrAccessControl
 kSecAttrAccessGroup (iOS; also OS X if kSecAttrSynchronizable specified) 可以在应用之间共享keychain中的数据，icloud备份
 kSecAttrAccessible (iOS; also OS X if kSecAttrSynchronizable specified)
 kSecAttrCreationDate
 kSecAttrModificationDate
 kSecAttrDescription
 kSecAttrComment
 kSecAttrCreator
 kSecAttrType
 kSecAttrLabel
 kSecAttrIsInvisible
 kSecAttrIsNegative
 kSecAttrAccount
 kSecAttrService
 kSecAttrGeneric
 kSecAttrSynchronizable
 */
