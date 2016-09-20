//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/zw/Documents/workspace/mpos/src/com/newland/mtype/common/EventConst.java
//
//  Created by zw on 13-6-7.
//

#import <Foundation/Foundation.h>
/*!
 @class
 @abstract 事件参数
 @discussion
 */
@interface NLEventConst : NSObject {
}
/**
 * 设备启动唤醒事件（主要是针对音频序列设备）
 */
+ (NSString *)EVENT_DEVICE_LAUNCH_FINISH_;
/**
 * 设备连接关闭事件
 */
+ (NSString *)EVENT_DEVICE_CONN_CLOSE_;
/**
 * 指令执行完成事件
 */
+ (NSString *)EVENT_EXECUTE_FINISH_;
/**
 * 键盘唤醒事件
 */
+ (NSString *)EVENT_KEYBOARD_AWARE_;
/**
 * pboc流程结束事件
 */
+ (NSString *)EVENT_PBOC_PROCESS_FINISH;
/**
 * ICCard 通信结束事件
 */
+ (NSString *)EVENT_ICCARD_CALL_FINISH;
/**
 * 扫描完成事件
 */
+ (NSString *)EVENT_SCANNER_FINISH;
/**
 * 刷卡完成事件
 */
+ (NSString *)EVENT_SWIPER_FINISH;
/**
 * PIN输入完成事件
 */
+ (NSString *)EVENT_PININPUT_FINISH;
/**
 * 开启读卡器完成事件
 */
+ (NSString *)EVENT_OPEN_CARDREADER_FINISH;
/**
 * 键盘读取结束事件
 */
+ (NSString*)EVENT_KEYBOARD_READING_FINISH;
@end
