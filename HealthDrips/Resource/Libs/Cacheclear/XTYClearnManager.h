#import <Foundation/Foundation.h>

@interface XTYClearnManager : NSObject

/**
 计算单个文件大小
 */
+ (float)fileSizeAtPath:(NSString *)path;

/**
 计算文件夹大小
 */
+ (float)folderSizeAtPath:(NSString *)path;

/**
 清除文件
 */
+ (void)clearCache:(NSString *)path;

@end
